#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <SDL.h>
#include <SDL_ttf.h>


void readkey();
int parsekey(unsigned long code, int repeat);
void drawText (SDL_Surface* screen, char* string, int x, int y);
void RunMenu(struct mCoreThread* context);