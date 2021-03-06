# NILTS
![alt tag](https://raw.githubusercontent.com/zesterer/nilts/master/documents/nilts-sign-small.png "Possibly the NILTS title graphic.")

A game about many things. I don't know what, since most content is randomly generated.

## What is NILTS?

Welcome to the git repository for NILTS. NILTS is a procedurally generated RPG/roguelike that introduces various mechanics inspired by such games as Dwarf Fortress, Minecraft and Nethack. Unlike the latter, movement is neither restricted to a grid nor restricted to two dimensions. NILTS will eventually attempt to introduce artifically intelligent civilisations, NPCs and many species of wild animal that change as time goes on both in population, physical appearance and demographics, creating a dynamic and fun game that can involve the player for many ~~hours~~ ~~days~~ years. It's emphasis on procedural generation means that every time you play NILTS, gameplay is always unique.

![alt tag](https://raw.githubusercontent.com/zesterer/nilts/master/documents/screenshots/2014-01-21.png)

## Current features

Of course, there's a reason this is on github. Most notably because it's not finished yet. At the moment, the following are functional:

- Core engine
- Basic world generation
- Basic NPCs
- Basic player character
- Movement, momentum and mass
- Basic particle system
- Variable terrain colour system (to make it look nice)
- Variable water
- Basic player graphics and rotation system

## Features currently in development

There are several features currently being developed:

- Items and inventory system
- Intelligent NPCs
- Memory leak fixes
- Saving / loading of worlds
- More advanced world / terrain generation
- Improved texture loading system
- Improved resource management system

## Compiling

There is a x86_64 binary included in this repository, but if you wish to compile NILTS yourself, you can download and compile it as below:

`git clone git://github.com/zesterer/nilts.git`

`cd nilts`

`sh cmd_to_compile.sh`

Then, simply run NILTS with:

`./nilts`

NOTE: If you have problems when compiling - errors about missing libraries - first run this command from the nilts directory:

`export LD_LIBRARY_PATH=libraries/shared-lib`

## FAQ

### Why the name 'NILTS'?

'NILTS' is an acronym for 'New and Improved Leon Trotsky Simulator', first beginning as an inside joke between a friend and myself. I grew to like the name, and have since adopted it as the permanent name for the project. Ironically, NILTS is not new, improved, or a simulator. And it most definitely has nothing to with Leon Trotsky.

### What are the controls?

WASD control movement. Q and E rotate the view. Arrow keys to look around. Nothing more yet.

### What features are on the roadmap?

Simple answer: I don't know. I'm not the kind of person to create plans. I do have a roadmap, but it's very subject to change so there's not much point putting it here. If you want features in development, see above.

### Which platforms will NILTS be released on?

When I get to a stable-ish alpha release, I will hopefully build for all 3 main platforms - Linux, Windows and Mac OSX. If anyone can get it working on more niche systems like a BSD derivative, please do contact me. Apart from denouncing my atheism and worshipping you as my new deity, I'd love to know just how the heck you managed it.

### There's... not much to do

Yes. I realised. NILTS is still in heavy development. VERY heavy development. At the moment, it runs, you see graphics, and that's it. It's not fun.

### Why so many utterly redundant FAQ questions?

I was bored.


## With credit to:
- A friend who I know for a fact would most definitely prefer to remain Quint. But yeah. He created most of the graphics and all of the music along with helping me with design and content planning. So thanks for that.

![alt tag](https://raw.githubusercontent.com/zesterer/nilts/master/documents/nilts.png)
