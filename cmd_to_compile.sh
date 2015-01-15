#!/usr/bin/sh

#1)
valac --thread --pkg sfml-graphics-2 --pkg sfml-window-2 --pkg sfml-system-2 --pkg sfml-audio-2 --pkg gee-0.8 --pkg gio-2.0 --target-glib=2.32 -g --vapidir=vapi \
src/main.vala \
src/World/world.vala \
src/World/region.vala \
src/World/ground_types.vala \
src/World/block_types.vala \
src/World/position.vala \
src/World/eventmanager.vala \
src/Entity/entity.vala \
src/Graphics/texture.vala \
src/Generation/noise.vala \
src/Generation/biomes.vala \
src/Generation/namegen.vala \
src/Display/display.vala \
src/Display/eventhandler.vala \
src/Display/render.vala \
src/Display/interface.vala \
src/Data/properties.vala \
src/Data/items.vala \
src/consts.vala \
-C

#Optional! Add:
#-X -lm -X -l -X csfml-graphics -X -l -X csfml-window -X -l -X csfml-system -X -l -X csfml-audio -g -X -fsanitize=address -o nilts
#above for debugging!

#2)
clang -c \
src/main.c \
src/World/world.c \
src/World/region.c \
src/World/ground_types.c \
src/World/block_types.c \
src/World/position.c \
src/World/eventmanager.c \
src/Entity/entity.c \
src/Graphics/texture.c \
src/Generation/noise.c \
src/Generation/biomes.c \
src/Generation/namegen.c \
src/Display/display.c \
src/Display/eventhandler.c \
src/Display/render.c \
src/Display/interface.c \
src/Data/properties.c \
src/Data/items.c \
src/consts.c \
 -Ilibraries/CSFML-2.1/include -Ilibraries/gee/include -Ilibraries/glib2/include

#3)
clang -o nilts \
main.o \
world.o \
region.o \
ground_types.o \
block_types.o \
position.o \
eventmanager.o \
entity.o \
texture.o \
noise.o \
biomes.o \
namegen.o \
display.o \
eventhandler.o \
render.o \
interface.o \
properties.o \
items.o \
consts.o \
-lgee-0.8 -lgobject-2.0 -lglib-2.0 -Llibraries/gee/lib -Llibraries/shared-lib -lcsfml-window -lcsfml-graphics -lcsfml-system -lcsfml-audio -lcsfml-network -lm \
-fsanitize=address

#NOT NEEDED AT THE MOMENT:
#-LCSFML-2.1/lib/gcc

echo "Build complete, but not necessarily successful."

#4)
rm *.o
rm src/*.c
rm src/Display/*.c
rm src/World/*.c
rm src/Graphics/*.c
rm src/Generation/*.c
rm src/Entity/*.c
rm src/Data/*.c
