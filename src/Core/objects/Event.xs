#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifndef aTHX_
#define aTHX_
#endif

#include <SDL.h>

MODULE = SDL::Event 	PACKAGE = SDL::Event    PREFIX = event_

=for documentation

SDL_Event -- General event structure

 typedef union{
  Uint8 type;
  SDL_ActiveEvent active;
  SDL_KeyboardEvent key;
  SDL_MouseMotionEvent motion;
  SDL_MouseButtonEvent button;
  SDL_JoyAxisEvent jaxis;
  SDL_JoyBallEvent jball;
  SDL_JoyHatEvent jhat;
  SDL_JoyButtonEvent jbutton;
  SDL_ResizeEvent resize;
  SDL_ExposeEvent expose;
  SDL_QuitEvent quit;
  SDL_UserEvent user;
  SDL_SysWMEvent syswm;
 } SDL_Event;


=cut

SDL_Event *
event_new (CLASS)
	char *CLASS
	CODE:
		RETVAL = (SDL_Event *) safemalloc(sizeof (SDL_Event));
	OUTPUT:
		RETVAL

Uint8
event_type ( event, ... )
	SDL_Event *event
	CODE:
		if( items > 1 )
		{
			event->type = SvIV( ST(1) );

		}
		RETVAL = event->type;
	OUTPUT:
		RETVAL

SDL_ActiveEvent *
event_active ( event, ... )
	SDL_Event *event
	PREINIT:
		char *CLASS = "SDL::ActiveEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->active);
	OUTPUT:
		RETVAL

Uint8
event_active_type ( event)
	SDL_Event *event
	CODE: 
		SDL_ActiveEvent * a = &(event->active);
		RETVAL = a->type;
	OUTPUT:
		RETVAL


Uint8
event_active_gain ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_ActiveEvent * a = &(event->active);
	
		if( items > 1 )
		{
			a->gain = SvIV( ST(1) );

		}
		RETVAL = a->gain;
	OUTPUT:
		RETVAL

Uint8
event_active_state ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_ActiveEvent * a = &(event->active);
		if( items > 1 )
		{
			a->state = SvIV( ST(1) );
		}
		RETVAL = a->state;
	OUTPUT:
		RETVAL


SDL_KeyboardEvent *
event_key ( event, ... )
	SDL_Event *event
	PREINIT:
		char *CLASS = "SDL::KeyboardEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->key);
	OUTPUT:
		RETVAL

Uint8
event_key_type ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_KeyboardEvent * a = &(event->key);

		if( items > 1 )
		{
			a->type = SvIV( ST(1) );
		}

		RETVAL = a->type;
	OUTPUT:
		RETVAL


Uint8
event_key_state ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_KeyboardEvent * a = &(event->key);

		if( items > 1 )
		{
			a->state = SvIV( ST(1) );
		}

		RETVAL = a->state;
	OUTPUT:
		RETVAL

SDL_keysym *
event_key_keysym ( event, ... )
	SDL_Event *event
	PREINIT:
		char* CLASS = "SDL::keysym";
	CODE: 
		SDL_KeyboardEvent * a = &(event->key);

		if( items > 1 )
		{
			SDL_keysym * ksp = (SDL_keysym * )SvPV( ST(1), PL_na) ;
			a->keysym = *ksp;
		}

		RETVAL = &(a->keysym);
	OUTPUT:
		RETVAL

Uint8
event_key_scancode ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_KeyboardEvent * a = &(event->key);
		SDL_keysym * b        = &(a->keysym);
		
		if( items > 1 )
		{
			b->scancode = SvIV( ST(1) );
		}

		RETVAL = b->scancode;
	OUTPUT:
		RETVAL

SDLKey *
event_key_sym ( event, ... )
	SDL_Event *event
	PREINIT:
		char* CLASS = "SDL::Key";
	CODE: 
		SDL_KeyboardEvent * a = &(event->key);
		SDL_keysym * b        = &(a->keysym);
		
		if( items > 1 )
		{
			SDLKey *kp  = (SDLKey * )SvPV( ST(1), PL_na) ;
			b->sym = *kp;
		}

		RETVAL = &(b->sym);
	OUTPUT:
		RETVAL

SDLMod *
event_key_mod ( event, ... )
	SDL_Event *event
	PREINIT:
		char* CLASS = "SDL::Mod";
	CODE: 
		SDL_KeyboardEvent * a = &(event->key);
		SDL_keysym * b        = &(a->keysym);
		
		if( items > 1 )
		{
			SDLMod *mp  = (SDLMod * )SvPV( ST(1), PL_na) ;
			b->mod = *mp;
		}

		RETVAL = &(b->mod);
	OUTPUT:
		RETVAL

Uint16
event_key_unicode ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_KeyboardEvent * a = &(event->key);
		SDL_keysym * b        = &(a->keysym);
		
		if( items > 1 )
		{
			b->unicode = SvIV( ST(1) );
		}

		RETVAL = b->unicode;
	OUTPUT:
		RETVAL

SDL_MouseMotionEvent *
event_motion ( event, ... )
	SDL_Event *event
	PREINIT:
		char *CLASS = "SDL::MouseMotionEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->motion);
	OUTPUT:
		RETVAL

SDL_MouseButtonEvent *
event_button ( event, ... )
	SDL_Event *event
	PREINIT:
		char *CLASS = "SDL::MouseButtonEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->button);
	OUTPUT:
		RETVAL

SDL_JoyAxisEvent *
event_jaxis ( event, ... )
	SDL_Event * event
	PREINIT:
		char *CLASS = "SDL::JoyAxisEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->jaxis);
	OUTPUT:
		RETVAL

Uint8
event_jaxis_type ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_JoyAxisEvent * a = &(event->jaxis);

		if( items > 1 )
		{
			a->type = SvIV( ST(1) );
		}

		RETVAL = a->type;
	OUTPUT:
		RETVAL

Uint8
event_jaxis_which ( event, ... )
	SDL_Event *event
	CODE:
		SDL_JoyAxisEvent * a = &(event->jaxis);

		if( items > 1 )
		{
			a->which = SvIV( ST(1) );
		}

		RETVAL = a->which;
	OUTPUT:
		RETVAL

Uint8
event_jaxis_axis ( event, ... )
	SDL_Event *event
	CODE:
		SDL_JoyAxisEvent * a = &(event->jaxis);

 		if( items > 1 )
		{
			a->axis = SvIV( ST(1) );
		}

		RETVAL = a->axis;
	OUTPUT:
		RETVAL

Sint16
event_jaxis_value ( event, ... )
	SDL_Event *event
	CODE:
		SDL_JoyAxisEvent * a = &(event->jaxis);

		if( items > 1 )
		{
			a->value = SvIV( ST(1) );
		}

		RETVAL = a->value;
	OUTPUT:
		RETVAL

SDL_JoyBallEvent *
event_jball ( event, ... )
	SDL_Event * event
	PREINIT:
		char *CLASS = "SDL::JoyBallEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->jball);
	OUTPUT:
		RETVAL

Uint8
event_jball_type ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_JoyBallEvent * a = &(event->jball);

		if( items > 1 )
		{
			a->type = SvIV( ST(1) );
		}
		
		RETVAL = event->type;
	OUTPUT:
		RETVAL

Uint8
event_jball_which ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_JoyBallEvent * a = &(event->jball);

		if( items > 1 )
		{
			a->which = SvIV( ST(1) );
		}
		
		RETVAL = a->which;
	OUTPUT:
		RETVAL

Uint8
event_jball_ball ( event, ... )
	SDL_Event *event
	CODE:
		SDL_JoyBallEvent * a = &(event->jball);

		if( items > 1 )
		{
			a->ball = SvIV( ST(1) );
		}
		
		RETVAL = a->ball;
	OUTPUT:
		RETVAL

Sint16
event_jball_xrel ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_JoyBallEvent * a = &(event->jball);

		if( items > 1 )
		{
			a->xrel = SvIV( ST(1) );
		}

		RETVAL = a->xrel;
	OUTPUT:
		RETVAL

Sint16
event_jball_yrel ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_JoyBallEvent * a = &(event->jball);

		if( items > 1 )
		{
			a->yrel = SvIV( ST(1) );
		}

		RETVAL = a->yrel;
	OUTPUT:
		RETVAL

SDL_JoyHatEvent *
event_jhat ( event, ... )
	SDL_Event *event
	PREINIT:
		char *CLASS = "SDL::JoyHatEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->jhat);
	OUTPUT:
		RETVAL

Uint8
event_jhat_type ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_JoyHatEvent * a = &(event->jhat);

		if( items > 1 )
		{
			a->which = SvIV( ST(1) );
		}

		RETVAL = a->type;
	OUTPUT:
		RETVAL

Uint8
event_jhat_which ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_JoyHatEvent * a = &(event->jhat);

		if( items > 1 )
		{
			a->which = SvIV( ST(1) );
		}

		RETVAL = a->which;
	OUTPUT:
		RETVAL

Uint8
event_jhat_hat ( event, ... )
	SDL_Event *event
	CODE:
		SDL_JoyHatEvent * a = &(event->jhat);

		if( items > 1 )
		{
			a->hat = SvIV( ST(1) );
		}

		RETVAL = a->hat;
	OUTPUT:
		RETVAL

Uint8
event_jhat_value ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_JoyHatEvent * a = &(event->jhat);

		if( items > 1 )
		{
			a->value = SvIV( ST(1) );
		}

		RETVAL = a->value;
	OUTPUT:
		RETVAL

SDL_JoyButtonEvent *
event_jbutton ( event, ... )
	SDL_Event *event
	PREINIT:
		char *CLASS = "SDL::JoyButtonEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->jbutton);
	OUTPUT:
		RETVAL

Uint8
event_jbutton_type ( event, ... )
	SDL_Event *event
	CODE:
		SDL_JoyButtonEvent * a = &(event->jbutton);

		if( items > 1 )
		{
			a->type = SvIV( ST(1) );
		}

		RETVAL = a->type;
	OUTPUT:
		RETVAL

Uint8
event_jbutton_which ( event )
	SDL_Event *event
	CODE: 
		SDL_JoyButtonEvent * a = &(event->jbutton);

		if( items > 1 )
		{
			a->which = SvIV( ST(1) );
		}

		RETVAL = a->which;
	OUTPUT:
		RETVAL

Uint8
event_jbutton_button ( event )
	SDL_Event *event
	CODE: 
		SDL_JoyButtonEvent * a = &(event->jbutton);

		if( items > 1 )
		{
			a->button = SvIV( ST(1) );
		}

		RETVAL = a->button;
	OUTPUT:
		RETVAL

Uint8
event_jbutton_state ( event )
	SDL_Event *event
	CODE: 
		SDL_JoyButtonEvent * a = &(event->jbutton);

		if( items > 1 )
		{
			a->state = SvIV( ST(1) );
		}

		RETVAL = a->state;
	OUTPUT:
		RETVAL

SDL_ResizeEvent *
event_resize ( event, ... )
	SDL_Event * event
	PREINIT:
		char *CLASS = "SDL::ResizeEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->resize);
	OUTPUT:
		RETVAL

Uint8
event_resize_type ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_ResizeEvent * r = &(event->resize);
		RETVAL = r->type;
	OUTPUT:
		RETVAL

int
event_resize_w ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_ResizeEvent * r = &(event->resize);
		if( items > 1 )
		{
			r->w = SvIV( ST(1) );

		}

		RETVAL = r->w;
	OUTPUT:
		RETVAL

int
event_resize_h ( event, ... )
	SDL_Event *event
	CODE: 
		 SDL_ResizeEvent * r = &(event->resize); 
		if( items > 1 )
		{
			r->h = SvIV( ST(1) );

		}

		RETVAL = r->h;
	OUTPUT:
		RETVAL

SDL_ExposeEvent *
event_expose ( event, ... )
	SDL_Event * event
	PREINIT:
		char *CLASS = "SDL::ExposeEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->expose);
	OUTPUT:
		RETVAL

Uint8
event_expose_type ( event, ... )
	SDL_Event *event
	CODE: 
		SDL_ExposeEvent * a = &(event->expose);

		if( items > 1 )
		{
			a->type = SvIV( ST(1) );
		}

		RETVAL = a->type;
	OUTPUT:
		RETVAL

SDL_QuitEvent *
event_quit ( event, ... )
	SDL_Event * event
	PREINIT:
		char *CLASS = "SDL::QuitEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->quit);
	OUTPUT:
		RETVAL

SDL_UserEvent *
event_user ( event, ... )
	SDL_Event * event
	PREINIT:
		char *CLASS = "SDL::UserEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->user);
	OUTPUT:
		RETVAL

SDL_SysWMEvent *
event_syswm ( event, ... )
	SDL_Event * event
	PREINIT:
		char *CLASS = "SDL::SysWMEvent";
	CODE:
		RETVAL = NULL;
		if ( &event != NULL ) 
		RETVAL = &(event->syswm);
	OUTPUT:
		RETVAL

void
event_DESTROY(self)
	SDL_Event *self
	CODE:
		safefree( (char *)self );