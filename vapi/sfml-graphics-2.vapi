using SFML.Window;
using SFML.System;

[CCode (cprefix = "sf", cheader_filename = "SFML/Graphics.h")]
namespace SFML.Graphics {
	/*
	 * Color
	 */
	
	[CCode (cname = "sfColor")]
	[SimpleType]
	public struct Color {
		public uint8 r;
		public uint8 g;
		public uint8 b;
		public uint8 a;
		
		[CCode (cname = "sfColor_fromRGB")]
		public static Color from_rgb (uint8 red, uint8 green, uint8 blue);
		
		[CCode (cname = "sfColor_fromRGBA")]
		public static Color from_rgba (uint8 red, uint8 green, uint8 blue, uint8 alpha);
		
		[CCode (cname = "sfColor_add")]
		public static Color add (Color c1, Color c2);
		
		[CCode (cname = "sfColor_modulate")]
		public static Color modulate (Color c1, Color c2);
	}
	
	[CCode (cname = "sfBlack")]
	public Color black;
	
	[CCode (cname = "sfWhite")]
	public Color white;
	
	[CCode (cname = "sfRed")]
	public Color red;
	
	[CCode (cname = "sfGreen")]
	public Color green;
	
	[CCode (cname = "sfBlue")]
	public Color blue;
	
	[CCode (cname = "sfYellow")]
	public Color yellow;
	
	[CCode (cname = "sfMagenta")]
	public Color magenta;
	
	[CCode (cname = "sfCyan")]
	public Color cyan;
	
	[CCode (cname = "sfTransparent")]
	public Color transparent;
	
	
	
	
	/*
	 * ConvexShape
	 */
	
	[CCode (cname = "sfConvexShape", copy_function = "sfConvexShape_copy", free_function = "sfConvexShape_destroy")]
	[Compact]
	public class ConvexShape {
		[CCode (cname = "sfConvexShape_create")]
		public ConvexShape ();
		
		[CCode (cname = "sfConvexShape_setPosition")]
		public void set_position (Vector2f position);
		
		[CCode (cname = "sfConvexShape_setRotation")]
		public void  set_rotation (float angle);
		
		[CCode (cname = "sfConvexShape_setScale")]
		public void  set_scale (Vector2f scale);
		
		[CCode (cname = "sfConvexShape_setOrigin")]
		public void  set_origin (Vector2f origin);
		
		[CCode (cname = "sfConvexShape_getPosition")]
		public Vector2f get_position ();
		
		[CCode (cname = "sfConvexShape_getRotation")]
		public float get_rotation ();
		
		[CCode (cname = "sfConvexShape_getScale")]
		public Vector2f get_scale ();
		
		[CCode (cname = "sfConvexShape_getOrigin")]
		public Vector2f get_origin ();
		
		[CCode (cname = "sfConvexShape_move")]
		public void move (Vector2f offset);
		
		[CCode (cname = "sfConvexShape_rotate")]
		public void rotate (float angle);
		
		[CCode (cname = "sfConvexShape_scale")]
		public void scale (Vector2f factors);
		
		[CCode (cname = "sfConvexShape_getTransform")]
		public Transform get_transform ();
		
		[CCode (cname = "sfConvexShape_getInverseTransform")]
		public Transform get_inverse_transform ();
		
		[CCode (cname = "sfConvexShape_setTexture")]
		public void set_texture (Texture texture, bool resetRect);
		
		[CCode (cname = "sfConvexShape_setTextureRect")]
		public void set_texture_rect (IntRect rect);
		
		[CCode (cname = "sfConvexShape_setFillColor")]
		public void set_fill_color (Color color);
		
		[CCode (cname = "sfConvexShape_setOutlineColor")]
		public void set_outline_color (Color color);
		
		[CCode (cname = "sfConvexShape_setOutlineThickness")]
		public void set_outline_thickness (float thickness);
		
		[CCode (cname = "sfConvexShape_getTexture")]
		public Texture get_texture ();
		
		[CCode (cname = "sfConvexShape_getTextureRect")]
		public IntRect get_texture_rect ();
		
		[CCode (cname = "sfConvexShape_getFillColor")]
		public Color get_fill_color ();
		
		[CCode (cname = "sfConvexShape_getOutlineColor")]
		public Color get_outline_color ();
		
		[CCode (cname = "sfConvexShape_getOutlineThickness")]
		public float get_outline_thickness ();
		
		[CCode (cname = "sfConvexShape_getPointCount")]
		public uint get_point_count ();
		
		[CCode (cname = "sfConvexShape_getPoint")]
		public Vector2f get_point (uint index);
		
		[CCode (cname = "sfConvexShape_setPointCount")]
		public void set_point_count (uint count);
		
		[CCode (cname = "sfConvexShape_setPoint")]
		public void set_point (uint index, Vector2f point);
		
		[CCode (cname = "sfConvexShape_getLocalBounds")]
		public FloatRect get_local_bounds ();
		
		[CCode (cname = "sfConvexShape_getGlobalBounds")]
		public FloatRect get_global_bounds ();
	}
	
	
	
	
	/*
	 * Blend mode
	 */
	
	public enum BlendMode {
		[CCode (cname = "sfBlendAlpha")]
		ALPHA,
		[CCode (cname = "sfBlendAdd")]
		ADD,
		[CCode (cname = "sfBlendMultiply")]
		MULTIPLY,
		[CCode (cname = "sfBlendNone")]
		NONE
	}
	
	
	
	
	/*
	 * Rect
	 */
	 
	[CCode (cname = "sfFloatRect")]
	[SimpleType]
	public struct FloatRect {
		[CCode (cname = "left")]
		public float x;
		[CCode (cname = "top")]
		public float y;
		[CCode (cname = "width")]
		public float width;
		[CCode (cname = "height")]
		public float height;
		
		[CCode (cname = "sfFloatRect_contains")]
		public bool contains (float x, float y);
		
		[CCode (cname = " sfFloatRect_intersects")]
		public bool intersects (out FloatRect rect, out FloatRect intersection);
	}
	
	//[CCode (cname = "sfIntRect")]
	//[SimpleType]
	public struct IntRect {
		[CCode (cname = "left")]
		public int x;
		[CCode (cname = "top")]
		public int y;
		[CCode (cname = "width")]
		public int width;
		[CCode (cname = "height")]
		public int height;
		
		[CCode (cname = "sfIntRect_contains")]
		public bool contains (int x, int y);
		
		[CCode (cname = " sfIntRect_intersects")]
		public bool intersects (out IntRect rect, out IntRect intersection);
	}
	
	
	
	
	/*
	 * Transform
	 */
	 
	public struct Transform {
		[CCode (cname = "matrix")]
		public float matrix[9];
		
		[CCode (cname = "sfTransform_fromMatrix")]
		public static Transform from_matrix(float a00, float a01, float a02,
                                                      float a10, float a11, float a12,
                                                      float a20, float a21, float a22);
		
		[CCode (cname = "sfTransform_getMatrix")]
		public void getMatrix(float* matrix);
		
		[CCode (cname = "sfTransform_getInverse")]
		public Transform get_inverse ();
		
		[CCode (cname = "sfTransform_transformPoint")]
		public Vector2f get_transform_point (Vector2f point);
		
		[CCode (cname = "sfTransform_transformRect")]
		public FloatRect transformRect (FloatRect rectangle);
		
		[CCode (cname = "sfTransform_combine")]
		public void combine(Transform other);
		
		[CCode (cname = "sfTransform_translate")]
		public void translate(float x, float y);
		
		[CCode (cname = "sfTransform_rotate")]
		public void rotate(float angle);
		
		[CCode (cname = "sfTransform_rotateWithCenter")]
		public void rotate_with_center(float angle, float center_x, float center_y);
		
		[CCode (cname = "sfTransform_scale")]
		public void scale(float scaleX, float scaleY);
		
		[CCode (cname = "sfTransform_WithCenter")]
		public void scale_with_center(float scale_x, float scale_y, float center_x, float center_y);
	}
	
	
	
	
	/*
	 * Transformable
	 */
	
	[CCode (cname = "sfTransformable", copy_function = "sfTransformable_copy", free_function = "sfTransformable_destroy")]
	[Compact]
	public class Transformable {
		[CCode (cname = "sfTransformable_create")]
		public Transformable();
		
		[CCode (cname = "sfTransformable_setPosition")]
		public void set_position (Vector2f position);
		
		[CCode (cname = "sfTransformable_setRotation")]
		public void set_rotation (float angle);
		
		[CCode (cname = "sfTransformable_setScale")]
		public void set_scale (Vector2f scale);
		
		[CCode (cname = "sfTransformable_setOrigin")]
		public void set_origin (Vector2f origin);
		
		[CCode (cname = "sfTransformable_getPosition")]
		public Vector2f get_position ();
		
		[CCode (cname = "sfTransformable_getRotation")]
		public float get_rotation  ();
		
		[CCode (cname = "sfTransformable_getScale")]
		public Vector2f get_scale ();
		
		[CCode (cname = "sfTransformable_getOrigin")]
		public Vector2f get_origin ();
		
		[CCode (cname = "sfTransformable_move")]
		public void move (Vector2f offset);
		
		[CCode (cname = "sfTransformable_rotate")]
		public void rotate (float angle);
		
		[CCode (cname = "sfTransformable_scale")]
		public void scale (Vector2f factors);
		
		[CCode (cname = "sfTransformable_getTransform")]
		public Transform get_transform ();
		
		[CCode (cname = "sfTransformable_getInverseTransform")]
		public Transform get_inverse_transform ();
	}
	
	
	
	
	/*
	 * CircleShape
	 */
	
	[CCode (cname = "sfCircleShape", copy_function = "sfCircleShape_copy", free_function = "sfCircleShape_destroy")]
	[Compact]
	public class CircleShape {
		[CCode (cname = "sfCircleShape_create")]
		public CircleShape ();
		
		[CCode (cname = "sfCircleShape_setPosition")]
		public void set_position (Vector2f position);
		
		[CCode (cname = "sfCircleShape_setRotation")]
		public void  set_rotation (float angle);
		
		[CCode (cname = "sfCircleShape_setScale")]
		public void  set_scale (Vector2f scale);
		
		[CCode (cname = "sfCircleShape_setOrigin")]
		public void  set_origin (Vector2f origin);
		
		[CCode (cname = "sfCircleShape_getPosition")]
		public Vector2f get_position ();
		
		[CCode (cname = "sfCircleShape_getRotation")]
		public float get_rotation ();
		
		[CCode (cname = "sfCircleShape_getScale")]
		public Vector2f get_scale ();
		
		[CCode (cname = "sfCircleShape_getOrigin")]
		public Vector2f get_origin ();
		
		[CCode (cname = "sfCircleShape_move")]
		public void move (Vector2f offset);
		
		[CCode (cname = "sfCircleShape_rotate")]
		public void rotate (float angle);
		
		[CCode (cname = "sfCircleShape_scale")]
		public void scale (Vector2f factors);
		
		[CCode (cname = "sfCircleShape_getTransform")]
		public Transform get_transform ();
		
		[CCode (cname = "sfCircleShape_getInverseTransform")]
		public Transform get_inverse_transform ();
		
		[CCode (cname = "sfCircleShape_setTexture")]
		public void set_texture (Texture texture, bool resetRect);
		
		[CCode (cname = "sfCircleShape_setTextureRect")]
		public void set_texture_rect (IntRect rect);
		
		[CCode (cname = "sfCircleShape_setFillColor")]
		public void set_fill_color (Color color);
		
		[CCode (cname = "sfCircleShape_setOutlineColor")]
		public void set_outline_color (Color color);
		
		[CCode (cname = "sfCircleShape_setOutlineThickness")]
		public void set_outline_thickness (float thickness);
		
		[CCode (cname = "sfCircleShape_getTexture")]
		public Texture get_texture ();
		
		[CCode (cname = "sfCircleShape_getTextureRect")]
		public IntRect get_texture_rect ();
		
		[CCode (cname = "sfCircleShape_getFillColor")]
		public Color get_fill_color ();
		
		[CCode (cname = "sfCircleShape_getOutlineColor")]
		public Color get_outline_color ();
		
		[CCode (cname = "sfCircleShape_getOutlineThickness")]
		public float get_outline_thickness ();
		
		[CCode (cname = "sfCircleShape_getPointCount")]
		public uint get_point_count ();
		
		[CCode (cname = "sfCircleShape_getPoint")]
		public Vector2f get_point (uint index);
		
		[CCode (cname = "sfCircleShape_setRadius")]
		public void set_radius (float radius);
		
		[CCode (cname = "sfCircleShape_getRadius")]
		public float get_radius ();
		
		[CCode (cname = "sfCircleShape_setPointCount")]
		public void set_point_count (uint count);
		
		[CCode (cname = "sfCircleShape_getLocalBounds")]
		public FloatRect get_local_bounds ();
		
		[CCode (cname = "sfCircleShape_getGlobalBounds")]
		public FloatRect get_global_bounds ();
	}
	
	
	
	
	/*
	 * Font
	 */
	
	[CCode (cname = "sfFont", copy_function = "sfFont_copy", free_function = "sfFont_destroy")]
	[Compact]
	public class Font {
		[CCode (cname = "sfFont_createFromFile")]
		public Font (string filename);
		
		[CCode (cname = "sfFont_createFromMemory")]
		public Font.from_memory (void* data, size_t size_in_bytes);
		
		[CCode (cname = "sfFont_createFromStream")]
		public Font.from_stream (InputStream stream);
		
		[CCode (cname = "sfFont_getGlyph")]
		public Glyph get_glyph (uint32 code_point, uint character_size, bool bold);
		
		[CCode (cname = "sfFont_getKerning")]
		public int get_kerning (uint32 first, uint32 second, uint character_size);
		
		[CCode (cname = "sfFont_getLineSpacing")]
		public int get_line_spacing (uint character_size);
		
		[CCode (cname = "sfFont_getTexture")]
		public Texture get_texture (uint character_size);
	}
	
	
	
	
	/*
	 * Glyph
	 */
	
	[SimpleType]
	public struct Glyph {
		[CCode (cname = "advance")]
		public int advance;
		[CCode (cname = "bounds")]
		public IntRect bounds;
		[CCode (cname = "textureRect")]
		public IntRect texture_rect;
	}
	
	
	
	
	/*
	 * Image
	 */
	
	[CCode (cname = "sfImage", copy_function = "sfImage_copy", free_function = "sfImage_destroy")]
	[Compact]
	public class Image {
		[CCode (cname = "sfImage_create")]
		public Image (uint width, uint height);
		
		[CCode (cname = "sfImage_createFromColor")]
		public Image.from_color (uint width, uint height, Color color);
		
		[CCode (cname = "sfImage_createFromPixels")]
		public Image.from_pixels (uint width, uint height, uint8* data);
		
		[CCode (cname = "sfImage_createFromFile")]
		public Image.from_file (string filename, IntRect area);
		
		[CCode (cname = "sfImage_createFromMemory")]
		public Image.from_memory (void* data, size_t size);
		
		[CCode (cname = "sfImage_createFromStream")]
		public Image.from_stream (InputStream stream);
		
		[CCode (cname = "sfImage_saveToFile")]
		public bool save_to_file (string filename);
		
		[CCode (cname = "sfImage_getSize")]
		public Vector2u get_size ();
		
		[CCode (cname = "sfImage_createMaskFromColor")]
		public void create_mask_from_color (Color color_key, uint8 alpha);
		
		[CCode (cname = "sfImage_copyImage")]
		public Image copy_image (Image source, uint dest_x, uint dest_y, IntRect source_rect);
		
		[CCode (cname = "sfImage_setPixel")]
		public void set_pixel (uint x, uint y, Color color);
		
		[CCode (cname = "sfImage_getPixel")]
		public Color get_pixel (uint x, uint y);
		
		[CCode (cname = "sfImage_getPixelsPtr")]
		public uint8* get_pixels_pointer ();
		
		[CCode (cname = "sfImage_flipHorizontally")]
		public void flip_horizontally ();
		
		[CCode (cname = "sfImage_flipVertically")]
		public void flip_vertically ();
	}
	
	
	
	
	/*
	 * PrimitiveType
	 */
	
	public enum PrimitiveType {
		POINTS,
		LINES,
		LINES_STRIP,
		TRIANGLES,
		TRIANGLES_STRIP,
		TRIANGLES_FAN,
		QUADS
	}
	
	
	
	
	/*
	 * RectangleShape
	 */
	
	[CCode (cname = "sfRectangleShape", copy_function = "sfRectangleShape_copy", free_function = "sfRectangleShape_destroy")]
	[Compact]
	public class RectangleShape {
		[CCode (cname = "sfRectangleShape_create")]
		public RectangleShape ();
		
		[CCode (cname = "sfRectangleShape_setPosition")]
		public void set_position (Vector2f position);
		
		[CCode (cname = "sfRectangleShape_setRotation")]
		public void  set_rotation (float angle);
		
		[CCode (cname = "sfRectangleShape_setScale")]
		public void  set_scale (Vector2f scale);
		
		[CCode (cname = "sfRectangleShape_setOrigin")]
		public void  set_origin (Vector2f origin);
		
		[CCode (cname = "sfRectangleShape_getPosition")]
		public Vector2f get_position ();
		
		[CCode (cname = "sfRectangleShape_getRotation")]
		public float get_rotation ();
		
		[CCode (cname = "sfRectangleShape_getScale")]
		public Vector2f get_scale ();
		
		[CCode (cname = "sfRectangleShape_getOrigin")]
		public Vector2f get_origin ();
		
		[CCode (cname = "sfRectangleShape_move")]
		public void move (Vector2f offset);
		
		[CCode (cname = "sfRectangleShape_rotate")]
		public void rotate (float angle);
		
		[CCode (cname = "sfRectangleShape_scale")]
		public void scale (Vector2f factors);
		
		[CCode (cname = "sfRectangleShape_getTransform")]
		public Transform get_transform ();
		
		[CCode (cname = "sfRectangleShape_getInverseTransform")]
		public Transform get_inverse_transform ();
		
		[CCode (cname = "sfRectangleShape_setTexture")]
		public void set_texture (Texture texture, bool resetRect);
		
		[CCode (cname = "sfRectangleShape_setTextureRect")]
		public void set_texture_rect (IntRect rect);
		
		[CCode (cname = "sfRectangleShape_setFillColor")]
		public void set_fill_color (Color color);
		
		[CCode (cname = "sfRectangleShape_setOutlineColor")]
		public void set_outline_color (Color color);
		
		[CCode (cname = "sfRectangleShape_setOutlineThickness")]
		public void set_outline_thickness (float thickness);
		
		[CCode (cname = "sfRectangleShape_getTexture")]
		public Texture get_texture ();
		
		[CCode (cname = "sfRectangleShape_getTextureRect")]
		public IntRect get_texture_rect ();
		
		[CCode (cname = "sfRectangleShape_getFillColor")]
		public Color get_fill_color ();
		
		[CCode (cname = "sfRectangleShape_getOutlineColor")]
		public Color get_outline_color ();
		
		[CCode (cname = "sfRectangleShape_getOutlineThickness")]
		public float get_outline_thickness ();
		
		[CCode (cname = "sfRectangleShape_getPointCount")]
		public uint get_point_count ();
		
		[CCode (cname = "sfRectangleShape_getPoint")]
		public Vector2f get_point (uint index);
		
		[CCode (cname = "sfRectangleShape_setSize")]
		public void set_size (Vector2f size);
		
		[CCode (cname = "sfRectangleShape_getSize")]
		public Vector2f get_size ();
		
		[CCode (cname = "sfRectangleShape_getLocalBounds")]
		public FloatRect get_local_bounds ();
		
		[CCode (cname = "sfRectangleShape_getGlobalBounds")]
		public FloatRect get_global_bounds ();
	}
	
	
	
	
	/*
	 * RenderStates
	 */
	
	public struct RenderStates {
		[CCode (cname = "blendMode")]
		public BlendMode blendMode;
		
		[CCode (cname = "transform")]
		public Transform transform;
		
		[CCode (cname = "texture")]
		public Texture texture;
		
		[CCode (cname = "shader")]
		public Shader shader;
	}
	
	
	
	
	/*
	 * RenderWindow
	 */
	
	[CCode (cname = "sfRenderWindow", free_function = "sfRenderWindow_destroy")]
	[Compact]
	public class RenderWindow : Window.Window {
		[CCode (cname = "sfRenderWindow_create")]
		public RenderWindow (VideoMode mode, string title, Style style, out ContextSettings settings);
		
		[CCode (cname = "sfRenderWindow_createUnicode")]
		public RenderWindow.create_unicode (VideoMode mode, string title, Style style, out ContextSettings settings);
		
		[CCode (cname = "sfRenderWindow_close")]
		public void close ();
		
		[CCode (cname = "sfRenderWindow_isOpen")]
		public bool is_open ();
		
		[CCode (cname = "sfRenderWindow_getSettings")]
		public ContextSettings get_settings ();
		
		[CCode (cname = "sfRenderWindow_pollEvent")]
		public bool poll_event (out Event event_to_fill);
		
		[CCode (cname = "sfRenderWindow_waitEvent")]
		public bool wait_event (out Event event_to_fill);
		
		[CCode (cname = "sfRenderWindow_getPosition")]
		public Vector2i get_position ();
		
		[CCode (cname = "sfWindow_setPosition")]
		public void set_position (Vector2i position);
		
		[CCode (cname = "sfRenderWindow_getSize")]
		public Vector2u get_size ();
		
		[CCode (cname = "sfRenderWindow_setTitle")]
		public void set_title (string title);
		
		[CCode (cname = "sfRenderWindow_setUnicodeTitle")]
		public void set_unicode_title (string title);
		
		[CCode (cname = "sfRenderWindow_setIcon")]
		public void set_icon (uint width, uint height, uint8* pixels);
		
		[CCode (cname = "sfRenderWindow_setSize")]
		public void set_size (uint width, uint height);
		
		[CCode (cname = "sfRenderWindow_setVisible")]
		public void set_visible (bool show);
		
		[CCode (cname = "sfRenderWindow_enableKeyRepeat")]
		public void enable_key_repeat (bool enable);
		
		[CCode (cname = "sfRenderWindow_setMouseCursorVisible")]
		public void set_mouse_cursor_visible (bool show);
		
		[CCode (cname = "sfRenderWindow_setVerticalSyncEnabled")]
		public bool set_vertical_sync_enabled (bool enable);
		
		[CCode (cname = "sfRenderWindow_setKeyRepeatEnabled")]
		public void set_key_repeat_enabled (bool enable);
		
		[CCode (cname = "sfRenderWindow_setActive")]
		public bool set_active (bool active = true);
		
		[CCode (cname = "sfRenderWindow_display")]
		public void display ();
		
		[CCode (cname = "sfRenderWindow_setFramerateLimit")]
		public void set_framerate_limit (uint limit);
		
		[CCode (cname = "sfRenderWindow_setJoystickThreshold")]
		public void set_joystick_threshold (float threshold);
		
		[CCode (cname = "sfRenderWindow_clear")]
		public void clear (Color color);
		
		[CCode (cname = "sfRenderWindow_setView")]
		public void set_view (View view);
		
		[CCode (cname = "sfRenderWindow_getView")]
		public View get_view ();
		
		[CCode (cname = "sfRenderWindow_getDefaultView")]
		public View get_default_view ();
		
		[CCode (cname = "sfRenderWindow_getViewport")]
		public IntRect get_viewport (View view);
		
		[CCode (cname = "sfRenderWindow_convertCoords")]
		protected Vector2f convert_coords (Vector2i point, out View? target_view);
		
		[CCode (cname = "sfRenderWindow_drawSprite")]
		public void draw_sprite (Sprite sprite, RenderStates? states);
		
		[CCode (cname = "sfRenderWindow_drawText")]
		public void draw_text (Text text, RenderStates? states);
		
		[CCode (cname = "sfRenderWindow_drawShape")]
		public void draw_shape (Shape shape, RenderStates? states);
		
		[CCode (cname = "sfRenderWindow_drawCircleShape")]
		public void draw_circle_shape (CircleShape shape, RenderStates? states);
		
		[CCode (cname = "sfRenderWindow_drawConvexShape")]
		public void draw_convex_shape (ConvexShape shape, RenderStates? states);
		
		[CCode (cname = "sfRenderWindow_drawRectangleShape")]
		public void draw_rectangle_shape (RectangleShape shape, RenderStates? states);
		
		[CCode (cname = "sfRenderWindow_drawVertexArray")]
		public void draw_vertex_shape (VertexArray vertices, RenderStates? states);
		
		[CCode (cname = "sfRenderWindow_drawPrimitives")]
		public void draw_primitives (VertexArray vertices, uint vertex_count,
							PrimitiveType type, RenderStates states);
		
		[CCode (cname = "sfRenderWindow_pushGLStates")]
		public void push_glstates ();
		
		[CCode (cname = "sfRenderWindow_popGLStates")]
		public void pop_glstates ();
		
		[CCode (cname = "sfRenderWindow_resetGLStates")]
		public void reset_glstates ();
		
		[CCode (cname = "capture")]
		public Image capture ();
		
		[CCode (cname = "sfMouse_getPositionRenderWindow")]
		public Vector2i get_position_render_window ();
		
		[CCode (cname = "sfMouse_setPositionRenderWindow")]
		public static void set_position_render_window (Vector2i position, RenderWindow relativeTo);
	}
	
	
	
	
	/*
	 * RenderTexture
	 */
	
	[CCode (cname = "sfRenderTexture", free_function = "sfRenderTexture_destroy")]
	[Compact]
	public class RenderTexture {
		[CCode (cname = "sfRenderTexture_create")]
		//public RenderTexture (VideoMode mode, string title, Style style, out ContextSettings settings);
		public RenderTexture (uint width, uint height, bool depthBuffer);
		
		[CCode (cname = "sfRenderTexture_close")]
		public void close ();
		
		[CCode (cname = "sfRenderTexture_getSize")]
		public Vector2u get_size ();
		
		[CCode (cname = "sfRenderTexture_setActive")]
		public bool set_active (bool active = true);
		
		[CCode (cname = "sfRenderTexture_display")]
		public void display ();
		
		[CCode (cname = "sfRenderTexture_setFramerateLimit")]
		public void set_framerate_limit (uint limit);
		
		[CCode (cname = "sfRenderTexture_setJoystickThreshold")]
		public void set_joystick_threshold (float threshold);
		
		[CCode (cname = "sfRenderTexture_clear")]
		public void clear (Color color);
		
		[CCode (cname = "sfRenderTexture_setView")]
		public void set_view (View view);
		
		[CCode (cname = "sfRenderTexture_getView")]
		public View get_view ();
		
		[CCode (cname = "sfRenderTexture_getDefaultView")]
		public View get_default_view ();
		
		[CCode (cname = "sfRenderTexture_getViewport")]
		public IntRect get_viewport (View view);
		
		[CCode (cname = "sfRenderTexture_mapPixelToCoords")]
		public Vector2f mappixel_tocoords (Vector2i point, out View? target_view);
		
		[CCode (cname = "sfRenderTexture_drawSprite")]
		public void draw_sprite (Sprite sprite, RenderStates? states);
		
		[CCode (cname = "sfRenderTexture_drawText")]
		public void draw_text (Text text, RenderStates? states);
		
		[CCode (cname = "sfRenderTexture_drawShape")]
		public void draw_shape (Shape shape, RenderStates? states);
		
		[CCode (cname = "sfRenderTexture_drawCircleShape")]
		public void draw_circle_shape (CircleShape shape, RenderStates? states);
		
		[CCode (cname = "sfRenderTexture_drawConvexShape")]
		public void draw_convex_shape (ConvexShape shape, RenderStates? states);
		
		[CCode (cname = "sfRenderTexture_drawRectangleShape")]
		public void draw_rectangle_shape (RectangleShape shape, RenderStates? states);
		
		[CCode (cname = "sfRenderTexture_drawVertexArray")]
		public void draw_vertex_shape (VertexArray vertices, RenderStates? states);
		
		[CCode (cname = "sfRenderTexture_drawPrimitives")]
		public void draw_primitives (VertexArray vertices, uint vertex_count,
							PrimitiveType type, RenderStates states);
		
		[CCode (cname = "sfRenderTexture_pushGLStates")]
		public void push_glstates ();
		
		[CCode (cname = "sfRenderTexture_popGLStates")]
		public void pop_glstates ();
		
		[CCode (cname = "sfRenderTexture_resetGLStates")]
		public void reset_glstates ();
		
		[CCode (cname = "sfRenderTexture_isSmooth")]
		public bool is_smooth ();
		
		[CCode (cname = "sfRenderTexture_getTexture")]
		public unowned Texture get_texture ();
	}
	
	
	
	
	/*
	 * Shader
	 */
	
	[CCode (cname = "sfShader", copy_function = "sfShader_copy", free_function = "sfShader_destroy")]
	[Compact]
	public class Shader {
		[CCode (cname = "sfShader_create")]
		public Shader (string vertexShaderFilename, string fragmentShaderFilename);
		
		[CCode (cname = "sfShader_createFromMemory")]
		public  Shader.from_memory (string vertexShader, string fragmentShader);
		
		[CCode (cname = "sfShader_createFromStream")]
		public  Shader.from_stream (InputStream vertexShaderStream, InputStream fragmentShaderStream);
		
		[CCode (cname = "sfShader_setFloatParameter")]
		public void set_float_param (string name, float x);
		
		[CCode (cname = "sfShader_setFloat2Parameter")]
		public void set_float_2param (string name, float x, float y);
		
		[CCode (cname = "sfShader_setFloat3Parameter")]
		public void set_float_3param (string name, float x, float y, float z);
		
		[CCode (cname = "sfShader_setFloat4Parameter")]
		public void set_float_4param (string name, float x, float y, float z, float w);
		
		[CCode (cname = "sfShader_setVector2Parameter")]
		public void set_vector_2param (string name, Vector2f vector);
		
		[CCode (cname = "sfShader_setVector3Parameter")]
		public void set_vector_3param (string name, Vector3f vector);
		
		[CCode (cname = "sfShader_setColorParameter")]
		public void set_color_param (string name, Color color);
		
		[CCode (cname = "sfShader_setTransformParameter")]
		public void set_transform_param (string name, Transform transform);
		
		[CCode (cname = "sfShader_setTextureParameter")]
		public void set_texture_param (string name, Texture texture);
		
		[CCode (cname = "sfShader_setCurrentTextureParameter")]
		public void set_current_texture_param (string name);
		
		[CCode (cname = "sfShader_bind")]
		public void bind ();
		
		[CCode (cname = "sfShader_isAvailable")]
		public bool is_available ();
	}
	
	
	
	
	/*
	 * Shape
	 */
	
	[CCode (cname = "sfShapeGetPointCountCallback")]
	public delegate uint GetPointCountCallback (void* arg);
	
	[CCode (cname = "sfShapeGetPointCallback")]
	public delegate Vector2f GetPointCallback (uint arg0, void* arg1);
	
	[CCode (cname = "sfShape", copy_function = "sfShape_copy", free_function = "sfShape_destroy")]
	[Compact]
	public class Shape {
		[CCode (cname = "sfShape_create")]
		public Shape (GetPointCountCallback getPointCount,
					GetPointCallback getPoint,
					void* userData);
		
		[CCode (cname = "sfShape_Circle")]
		public static Shape.circle (Vector2f center, float radius, Color color, float outline, Color outline_color);
		
		[CCode (cname = "sfShape_Rectangle")]
		public static Shape.rectangle (float x1, float y1, float x2, float y2, Color color, float outline, Color outline_color);
		
		[CCode (cname = "sfShape_AddPoint")]
		public void add_point (float x, float y, Color color, Color outline_color);
		
		[CCode (cname = "sfShape_setPointColor")]
		public void set_point_color (uint index, Color color);
		
		[CCode (cname = "sfShape_setPosition")]
		public void set_position (Vector2f position);
		
		[CCode (cname = "sfShape_setScale")]
		public void set_scale (Vector2f scale);
		
		[CCode (cname = "sfShape_setRotation")]
		public void set_rotation (float rotation);
		
		[CCode (cname = "sfShape_setOrigin")]
		public void set_origin (Vector2f origin);
		
		[CCode (cname = "sfShape_getPosition")]
		public Vector2f get_position ();
		
		[CCode (cname = "sfShape_getScale")]
		public Vector2f get_scale ();
		
		[CCode (cname = "sfShape_getRotation")]
		public float get_rotation ();
		
		[CCode (cname = "sfShape_getOrigin")]
		public Vector2f get_origin ();
		
		[CCode (cname = "sfShape_move")]
		public void move (Vector2f offset);
		
		[CCode (cname = "sfShape_scale")]
		public void scale (Vector2f factors);
		
		[CCode (cname = "sfShape_rotate")]
		public void rotate (float angle);
		
		[CCode (cname = "sfShape_getTransform")]
		public Transform get_transform ();
		
		[CCode (cname = "sfShape_getInverseTransform")]
		public Transform get_inverse_transform ();
		
		[CCode (cname = "sfShape_setTexture")]
		public void set_texture (Texture texture, bool reset_rect);
		
		[CCode (cname = "sfShape_setTextureRect")]
		public void set_texture_rect (IntRect rect);
		
		[CCode (cname = "sfShape_setFillColor")]
		public void set_color (Color color);
		
		[CCode (cname = "sfShape_setOutlineColor")]
		public void set_outline_color (Color color);
		
		[CCode (cname = "sfShape_setOutlineThickness")]
		public float set_outline_thickness (float thickness);
		
		[CCode (cname = "sfShape_getTexture")]
		public Texture get_texture ();
		
		[CCode (cname = "sfShape_getTextureRect")]
		public IntRect get_texture_rect ();
		
		[CCode (cname = "sfShape_getFillColor")]
		public Color get_fill_color ();
		
		[CCode (cname = "sfShape_getOutlineColor")]
		public Color get_outline_color ();
		
		[CCode (cname = "sfShape_getOutlineThickness")]
		public float get_outline_thickness ();
		
		[CCode (cname = "sfShape_getPointsCount")]
		public uint get_points_count ();
		
		[CCode (cname = "sfShape_getPoint")]
		public Vector2f get_point (uint index);
		
		[CCode (cname = "sfShape_getLocalBounds")]
		public FloatRect get_local_bounds ();
		
		[CCode (cname = "sfShape_getGlobalBounds")]
		public FloatRect get_global_bounds ();
		
		[CCode (cname = "sfShape_update")]
		public void update ();
	}
	
	
	
	
	/*
	 * Sprite
	 */
	
	[CCode (cname = "sfSprite", copy_function = "sfSprite_copy", free_function = "sfSprite_destroy")]
	[Compact]
	public class Sprite {
		[CCode (cname = "sfSprite_create")]
		public Sprite ();
		
		[CCode (cname = "sfSprite_setPosition")]
		public void set_position (Vector2f position);
		
		[CCode (cname = "sfSprite_setScale")]
		public void set_scale (Vector2f scale);
		
		[CCode (cname = "sfSprite_setRotation")]
		public void set_rotation (float rotation);
		
		[CCode (cname = "sfSprite_setOrigin")]
		public void set_origin (Vector2f origin);
		
		[CCode (cname = "sfSprite_getPosition")]
		public Vector2f get_position ();
		
		[CCode (cname = "sfSprite_getScale")]
		public Vector2f get_scale ();
		
		[CCode (cname = "sfSprite_getRotation")]
		public float get_rotation ();
		
		[CCode (cname = "sfSprite_getOrigin")]
		public Vector2f get_origin ();
		
		[CCode (cname = "sfSprite_move")]
		public void move (Vector2f offset);
		
		[CCode (cname = "sfSprite_scale")]
		public void scale (Vector2f factors);
		
		[CCode (cname = "sfSprite_rotate")]
		public void rotate (float angle);
		
		[CCode (cname = "sfSprite_getTransform")]
		public Transform get_transform ();
		
		[CCode (cname = "sfSprite_getInverseTransform")]
		public Transform get_inverse_transform ();
		
		[CCode (cname = "sfSprite_setTexture")]
		public void set_texture (Texture texture, bool reset_rect);
		
		[CCode (cname = "sfSprite_setTextureRect")]
		public void set_texture_rect (IntRect rectangle);
		
		[CCode (cname = "sfSprite_setColor")]
		public void set_color (Color color);
		
		[CCode (cname = "sfSprite_getTexture")]
		public Texture get_texture ();
		
		[CCode (cname = "sfSprite_getTextureRect")]
		public IntRect get_texture_rect ();
		
		[CCode (cname = "sfSprite_getColor")]
		public Color get_color ();
		
		[CCode (cname = "sfSprite_getLocalBounds")]
		public FloatRect get_local_bounds ();
		
		[CCode (cname = "sfSprite_getGlobalBounds")]
		public FloatRect get_global_bounds ();
	}
	
	
	
	
	/*
	 * Text
	 */
	
	public enum TextStyle {
		[CCode (cname = "sfTextRegular")]
		REGULAR = 0,
		[CCode (cname = "sfTextBold")]
		BOLD = 1 << 0,
		[CCode (cname = "sfTextItalic")]
		ITALIC = 1 << 1,
		[CCode (cname = "sfTextUnderlined")]
		UNDERLINED = 1 << 2
	}
	
	[CCode (cname = "sfText", copy_function = "sfText_copy", free_function = "sfText_destroy")]
	[Compact]
	public class Text {
		[CCode (cname = "sfText_create")]
		public Text ();
		
		[CCode (cname = "sfText_setPosition")]
		public void set_position (Vector2f position);
		
		[CCode (cname = "sfText_setScale")]
		public void set_scale (Vector2f scale);
		
		[CCode (cname = "sfText_setRotation")]
		public void set_rotation (float angle);
		
		[CCode (cname = "sfText_setOrigin")]
		public void set_origin (Vector2f origin);
		
		[CCode (cname = "sfText_getPosition")]
		public Vector2f get_position ();
		
		[CCode (cname = "sfText_getRotation")]
		public float get_rotation ();
		
		[CCode (cname = "sfText_getScale")]
		public Vector2f get_scale ();
		
		[CCode (cname = "sfText_getOrigin")]
		public Vector2f get_origin ();
		
		[CCode (cname = "sfText_move")]
		public void move (Vector2f offset);
		
		[CCode (cname = "sfText_scale")]
		public void scale (Vector2f factors);
		
		[CCode (cname = "sfText_rotate")]
		public void rotate (float angle);
		
		[CCode (cname = "sfText_getTransform")]
		public Transform get_transform ();
		
		[CCode (cname = "sfText_getInverseTransform")]
		public Transform get_inverse_transform ();
		
		[CCode (cname = "sfText_setString")]
		public void set_string (string text);
		
		[CCode (cname = "sfText_setUnicodeString")]
		public void set_unicode_string (uint32* text);
		
		[CCode (cname = "sfText_setFont")]
		public void set_font (Font font);
		
		[CCode (cname = "sfText_setCharacterSize")]
		public void set_character_size (uint size);
		
		[CCode (cname = "sfText_setStyle")]
		public void set_style (TextStyle style);
		
		[CCode (cname = "sfText_setColor")]
		public void set_color (Color color);
		
		[CCode (cname = "sfText_getString")]
		public string get_string ();
		
		[CCode (cname = "sfText_getUnicodeString")]
		public uint32* get_unicode_string ();
		
		[CCode (cname = "sfText_getFont")]
		public Font get_font ();
		
		[CCode (cname = "sfText_getCharacterSize")]
		public uint get_character_size ();
		
		[CCode (cname = "sfText_getStyle")]
		public TextStyle get_style ();
		
		[CCode (cname = "sfText_getColor")]
		public Color get_color ();
		
		[CCode (cname = "sfText_findCharacterPos")]
		public Vector2f find_char_pos (ulong index);
		
		[CCode (cname = "sfText_getLocalBounds")]
		public FloatRect get_local_bounds ();
		
		[CCode (cname = "sfText_getGlobalBounds")]
		public FloatRect get_global_bounds ();
	}
	
	
	
	
	/*
	 * Texture
	 */
	
	[CCode (cname = "sfTexture", copy_function = "sfTexture_copy", free_function = "sfTexture_destroy")]
	[Compact]
	public class Texture {
		[CCode (cname = "sfTexture_create")]
		public Texture (uint width, uint height);
		
		[CCode (cname = "sfTexture_createFromImage")]
		public Texture.from_image (Image image, IntRect area);
		
		[CCode (cname = "sfTexture_createFromFile")]
		public Texture.from_file (string filename, IntRect area);
		
		[CCode (cname = "sfTexture_createFromMemory")]
		public Texture.from_memory (void* data, size_t size);
		
		[CCode (cname = "sfTexture_createFromStream")]
		public Texture.from_stream (InputStream stream);
		
		[CCode (cname = "sfTexture_copyToImage")]
		public Image copy_to_image ();
		
		[CCode (cname = "sfImage_getSize")]
		public Vector2u get_size ();
		
		[CCode (cname = "sfTexture_updateFromPixels")]
		public void update_from_pixels (uint8* pixels, uint x, uint y, uint height, uint width);
		
		[CCode (cname = "sfTexture_updateFromImage")]
		public void update_from_image (uint8* pixels, uint width, uint height, uint x, uint y);
		
		[CCode (cname = "sfTexture_updateFromWindow")]
		public void update_from_window (uint8* pixels, Window.Window window, uint x, uint y);
		
		[CCode (cname = "sfTexture_updateFromRenderWindow")]
		public void update_from_render_window (uint8* pixels, RenderWindow window, uint x, uint y);
		
		[CCode (cname = "sfTexture_bind")]
		public void bind ();
		
		[CCode (cname = "sfTexture_setSmooth")]
		public void set_smooth (bool smooth);
		
		[CCode (cname = "sfTexture_isSmooth")]
		public bool is_smooth ();
		
		[CCode (cname = "sfTexture_setRepeated")]
		public void set_repeated (bool repeated);
		
		[CCode (cname = "sfTexture_isRepeated")]
		public bool is_repeated ();
		
		[CCode (cname = "sfTexture_getMaximumSize")]
		public void get_max_size ();
	}
	
	
	
	
	/*
	 * Vertex
	 */
	[CCode (cname = "sfVertex")]
	[SimpleType]
	public struct Vertex{
		[CCode (cname = "position")]
		Vector2f position;
		
		[CCode (cname = "color")]
		Color color;
		
		[CCode (cname = "texCoords")]
		Vector2f tex_coords;
	}
	
	
	
	/*
	 * VertexArray
	 */
	
	[CCode (cname = "sfVertexArray", copy_function = "sfVertexArray_copy", free_function = "sfVertexArray_destroy")]
	[Compact]
	public class VertexArray {
		[CCode (cname = "sfVertexArray_create")]
		public VertexArray ();
		
		[CCode (cname = "sfVertexArray_getVertexCount")]
		public uint get_vertex_count ();
		
		[CCode (cname = "sfVertexArray_getVertex")]
		public Vertex get_vertex (uint index);
		
		[CCode (cname = "sfVertexArray_clear")]
		public void clear ();
		
		[CCode (cname = "sfVertexArray_resize")]
		public void resize (uint vertex_count);
		
		[CCode (cname = "sfVertexArray_append")]
		public void append (Vertex vertex);
		
		[CCode (cname = "sfVertexArray_setPrimitiveType")]
		public void set_primitive_type (PrimitiveType type);
		
		[CCode (cname = "sfVertexArray_getPrimitiveType")]
		public PrimitiveType get_primitive_type ();
		
		[CCode (cname = "sfVertexArray_getBounds")]
		public FloatRect get_bounds ();
	}
	
	
	
	
	/*
	 * View
	 */
	
	[CCode (cname = "sfView", copy_function = "sfView_copy", free_function = "sfView_destroy")]
	[Compact]
	public class View {
		[CCode (cname = "sfView_create")]
		public View ();
		
		[CCode (cname = "sfView_createFromRect")]
		public View.from_rect (FloatRect rectangle);
		
		[CCode (cname = "sfView_setCenter")]
		public void set_center (Vector2f center);
		
		[CCode (cname = "sfView_setSize")]
		public void set_size (Vector2f size);
		
		[CCode (cname = "sfView_setRotation")]
		public void set_rotation (float rotation);
		
		[CCode (cname = "sfView_setViewport")]
		public void set_viewport (FloatRect viewport);
		
		[CCode (cname = "sfView_reset")]
		public void reset (FloatRect rectangle);
		
		[CCode (cname = "sfView_getCenter")]
		public Vector2f get_center ();
		
		[CCode (cname = "sfView_getSize")]
		public Vector2f get_size ();
		
		[CCode (cname = "sfView_getRotation")]
		public float get_rotation ();
		
		[CCode (cname = "sfView_getViewport")]
		public FloatRect get_viewport ();
		
		[CCode (cname = "sfView_move")]
		public void move (Vector2f offset);
		
		[CCode (cname = "sfView_rotate")]
		public void rotate (float angle);
		
		[CCode (cname = "sfView_zoom")]
		public void zoom (float factor);
	}
}
