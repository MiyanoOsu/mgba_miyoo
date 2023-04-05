#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <SDL.h>
#include <SDL_ttf.h>

#include "sdl-events.h"

#include <mgba/core/core.h>
#include <mgba/core/input.h>
#include <mgba/core/serialize.h>
#include <mgba/core/thread.h>


static int g_dirty = 1;
static unsigned long g_key = 0, last_key;
static int counter = 0;
SDL_Surface *screen;

void readkey() 
{
	SDL_Event event;

	last_key = g_key;

	// loop, handling all pending events
	while(SDL_PollEvent(&event))
		switch(event.type) {
			case SDL_KEYUP:
				SDL_EnableKeyRepeat(0,0);
				g_key = 0;
				return;
			case SDL_KEYDOWN:
				SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY + 100, SDL_DEFAULT_REPEAT_INTERVAL);
				g_key = event.key.keysym.sym;
				return;
		}

	if (g_key == 0)
		counter = 0;
}

int parsekey(unsigned long code, int repeat) 
{
	if (g_key == code) {
		if (g_key != last_key) {
			counter = 0;
			g_dirty = 1;
			return 1;
		}

		if (repeat && (counter > 5)) {
			counter = 0;
			g_dirty = 1;
			return 1;
		}

		counter++;
		return 0;
	}

	return 0;
}

void drawText (SDL_Surface* screen, char* string, int x, int y)
{	
	
	//change patch to font depend on where the font place
	TTF_Font* font = TTF_OpenFont("/mnt/emus/mgba/DejaVuSans.ttf", 16);
	if(!font) {printf("TTF_OpenFont: %s  \nPlease check mgba_miyoo/src/platform/sdl/menu.c\n", TTF_GetError());}

	SDL_Color textColor = { 255, 255, 255 };

	SDL_Surface* textSurface = TTF_RenderText_Solid(font, string, textColor);

	SDL_Rect textLocation = { x, y, 0, 0 };
	SDL_BlitSurface(textSurface, NULL, screen, &textLocation);
	SDL_FreeSurface(textSurface);

	TTF_CloseFont(font);

}


char *menu[] = {"Resume","Save state","Load state","Screenshot","Exit"};
char *slot[] = {"Slot 1","Slot 2","Slot 3","Slot 4","Slot 5","Slot 6","Slot 7","Slot 8","Slot 9"};


void RunMenu(struct mCoreThread* context) {
	int i=1, j=0, k=76,index=0,sel=-1,sl=-1;

	screen = SDL_GetVideoSurface();
		if (screen == NULL)return;
	
	SDL_LockSurface(screen);

	TTF_Init();
	
	while (i==1){

		readkey();
		
		if(g_dirty){
			SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0, 20, 80));
			if (sel==1 || sel==2) {
				if(parsekey(SDLK_LCTRL,0)) {sel=-1;index=0;}
				if(parsekey(SDLK_UP,0)) index-=1;
				if(parsekey(SDLK_DOWN,0)) index+=1;
				if(parsekey(SDLK_LALT,0)) sl=index;
				if(index <0) index=8;
				if(index >8) index=0;

				switch(sl){
					case 0:
					case 1:
					case 2:
					case 3:
					case 4:
					case 5:
					case 6:
					case 7:
					case 8:
						mCoreThreadInterrupt(context);
						if(sel==1) {mCoreSaveState(context->core, sl + 1, SAVESTATE_SAVEDATA | SAVESTATE_SCREENSHOT | SAVESTATE_RTC);sl=-1;}
						if(sel==2) {mCoreLoadState(context->core, sl + 1, SAVESTATE_SCREENSHOT | SAVESTATE_RTC);sl=-1;}
						mCoreThreadContinue(context);mCoreThreadUnpause(context);sel=-1;i=0;
						break;
				}

				for(j=0,k=40;j<9;j++,k+=18) {drawText(screen, slot[j],60,k);}
				drawText(screen,"*",50,index*18+40);
			}		

			else {	
				if(parsekey(SDLK_LCTRL,0)) {mCoreThreadUnpause(context);sel=-1;break;}
				if(parsekey(SDLK_UP,0)) index-=1;
				if(parsekey(SDLK_DOWN,0)) index+=1;
				if(parsekey(SDLK_LALT,0)) {sel=index;index=0;}
				if(index < 0) index=4;
				if(index >4) index=0;
				if (sel==0) {mCoreThreadUnpause(context);sel=-1;break;}
				if (sel==4) {mCoreThreadEnd(context);break;}
				if (sel==3) {mCoreTakeScreenshot(context->core);sel=-1;}

				for(j=0,k=76;j<5;j++,k+=18) {drawText(screen, menu[j],60,k);}
				drawText(screen,"*",50,index*18+76);
			}

		}
		SDL_UnlockSurface(screen);
		SDL_Flip(screen);
	}
	TTF_Quit();
}
