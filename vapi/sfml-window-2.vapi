using SFML.System;

[CCode (cprefix = "sf", cheader_filename = "SFML/Window.h")]
namespace SFML.Window {
	/*
	 * Context
	 */
	
	[CCode (cname = "sfContext", copy_function = "sfContext", free_function = "sfContext_destroy")]
	[Compact]
	public class Context {
		[CCode (cname = "sfContext_create")]
		public Context ();
		
		[CCode (cname = "sfContext_set_active")]
		public void set_active (bool active);
	}
	
	
	
	
	/*
	 * Events
	 */
	
	public enum KeyCode {
		[CCode (cname = "sfKeyA")]
		A = 'a',
		[CCode (cname = "sfKeyB")]
		B = 'b',
		[CCode (cname = "sfKeyC")]
		C = 'c',
		[CCode (cname = "sfKeyD")]
		D = 'd',
		[CCode (cname = "sfKeyE")]
		E = 'e',
		[CCode (cname = "sfKeyF")]
		F = 'f',
		[CCode (cname = "sfKeyG")]
		G = 'g',
		[CCode (cname = "sfKeyH")]
		H = 'h',
		[CCode (cname = "sfKeyI")]
		I = 'i',
		[CCode (cname = "sfKeyJ")]
		J = 'j',
		[CCode (cname = "sfKeyK")]
		K = 'k',
		[CCode (cname = "sfKeyL")]
		L = 'l',
		[CCode (cname = "sfKeyM")]
		M = 'm',
		[CCode (cname = "sfKeyN")]
		N = 'n',
		[CCode (cname = "sfKeyO")]
		O = 'o',
		[CCode (cname = "sfKeyP")]
		P = 'p',
		[CCode (cname = "sfKeyQ")]
		Q = 'q',
		[CCode (cname = "sfKeyR")]
		R = 'r',
		[CCode (cname = "sfKeyS")]
		S = 's',
		[CCode (cname = "sfKeyT")]
		T = 't',
		[CCode (cname = "sfKeyU")]
		U = 'u',
		[CCode (cname = "sfKeyV")]
		V = 'v',
		[CCode (cname = "sfKeyW")]
		W = 'w',
		[CCode (cname = "sfKeyX")]
		X = 'x',
		[CCode (cname = "sfKeyY")]
		Y = 'y',
		[CCode (cname = "sfKeyZ")]
		Z = 'z',
		[CCode (cname = "sfKeyNum0")]
		NUM_0 = '0',
		[CCode (cname = "sfKeyNum1")]
		NUM_1 = '1',
		[CCode (cname = "sfKeyNum2")]
		NUM_2 = '2',
		[CCode (cname = "sfKeyNum3")]
		NUM_3 = '3',
		[CCode (cname = "sfKeyNum4")]
		NUM_4 = '4',
		[CCode (cname = "sfKeyNum5")]
		NUM_5 = '5',
		[CCode (cname = "sfKeyNum6")]
		NUM_6 = '6',
		[CCode (cname = "sfKeyNum7")]
		NUM_7 = '7',
		[CCode (cname = "sfKeyNum8")]
		NUM_8 = '8',
		[CCode (cname = "sfKeyNum9")]
		NUM_9 = '9',
		[CCode (cname = "sfKeyEscape")]
		ESCAPE = 255,
		[CCode (cname = "sfKeyLControl")]
		L_CONTROL,
		[CCode (cname = "sfKeyLShift")]
		L_SHIFT,
		[CCode (cname = "sfKeyLAlt")]
		L_ALT,
		[CCode (cname = "sfKeyLSystem")]
		L_SYSTEM,
		[CCode (cname = "sfKeyRControl")]
		R_CONTROL,
		[CCode (cname = "sfKeyRShift")]
		R_SHIFT,
		[CCode (cname = "sfKeyRAlt")]
		R_ALT,
		[CCode (cname = "sfKeyRSystem")]
		R_SYSTEM,
		[CCode (cname = "sfKeyMenu")]
		MENU,
		[CCode (cname = "sfKeyLBracket")]
		L_BRACKET,
		[CCode (cname = "sfKeyRBracket")]
		R_BRACKET,
		[CCode (cname = "sfKeySemiColon")]
		SEMICOLON,
		[CCode (cname = "sfKeyComma")]
		COMMA,
		[CCode (cname = "sfKeyPeriod")]
		PERIOD,
		[CCode (cname = "sfKeyQuote")]
		QUOTE,
		[CCode (cname = "sfKeySlash")]
		SLASH,
		[CCode (cname = "sfKeyBackSlash")]
		BACKSLASH,
		[CCode (cname = "sfKeyTilde")]
		TILDE,
		[CCode (cname = "sfKeyEqual")]
		EQUAL,
		[CCode (cname = "sfKeyDash")]
		DASH,
		[CCode (cname = "sfKeySpace")]
		SPACE,
		[CCode (cname = "sfKeyReturn")]
		RETURN,
		[CCode (cname = "sfKeyBack")]
		BACK,
		[CCode (cname = "sfKeyTab")]
		TAB,
		[CCode (cname = "sfKeyPageUp")]
		PAGE_UP,
		[CCode (cname = "sfKeyPageDown")]
		PAGE_DOWN,
		[CCode (cname = "sfKeyEnd")]
		END,
		[CCode (cname = "sfKeyHome")]
		HOME,
		[CCode (cname = "sfKeyInsert")]
		INSERT,
		[CCode (cname = "sfKeyDelete")]
		DELETE,
		[CCode (cname = "sfKeyAdd")]
		ADD,
		[CCode (cname = "sfKeySubtract")]
		SUBTRACT,
		[CCode (cname = "sfKeyMultiply")]
		MULTIPLY,
		[CCode (cname = "sfKeyDivide")]
		DIVIDE,
		[CCode (cname = "sfKeyLeft")]
		LEFT,
		[CCode (cname = "sfKeyRight")]
		RIGHT,
		[CCode (cname = "sfKeyUp")]
		UP,
		[CCode (cname = "sfKeyDown")]
		DOWN,
		[CCode (cname = "sfKeyNumpad0")]
		NUMPAD_0,
		[CCode (cname = "sfKeyNumpad1")]
		NUMPAD_1,
		[CCode (cname = "sfKeyNumpad2")]
		NUMPAD_2,
		[CCode (cname = "sfKeyNumpad3")]
		NUMPAD_3,
		[CCode (cname = "sfKeyNumpad4")]
		NUMPAD_4,
		[CCode (cname = "sfKeyNumpad5")]
		NUMPAD_5,
		[CCode (cname = "sfKeyNumpad6")]
		NUMPAD_6,
		[CCode (cname = "sfKeyNumpad7")]
		NUMPAD_7,
		[CCode (cname = "sfKeyNumpad8")]
		NUMPAD_8,
		[CCode (cname = "sfKeyNumpad9")]
		NUMPAD_9,
		[CCode (cname = "sfKeyF1")]
		F1,
		[CCode (cname = "sfKeyF2")]
		F2,
		[CCode (cname = "sfKeyF3")]
		F3,
		[CCode (cname = "sfKeyF4")]
		F4,
		[CCode (cname = "sfKeyF5")]
		F5,
		[CCode (cname = "sfKeyF6")]
		F6,
		[CCode (cname = "sfKeyF7")]
		F7,
		[CCode (cname = "sfKeyF8")]
		F8,
		[CCode (cname = "sfKeyF9")]
		F9,
		[CCode (cname = "sfKeyF10")]
		F10,
		[CCode (cname = "sfKeyF11")]
		F11,
		[CCode (cname = "sfKeyF12")]
		F12,
		[CCode (cname = "sfKeyF13")]
		F13,
		[CCode (cname = "sfKeyF14")]
		F14,
		[CCode (cname = "sfKeyF15")]
		F15,
		[CCode (cname = "sfKeyPause")]
		PAUSE,
		
		[CCode (cname = "sfKeyCount")]
		KEY_COUNT //Useless in Vala
	}
	
	
	public enum MouseButton {
		[CCode (cname = "sfButtonLeft")]
		LEFT,
		[CCode (cname = "sfButtonRight")]
		RIGHT,
		[CCode (cname = "sfButtonMiddle")]
		MIDDLE,
		[CCode (cname = "sfButtonX1")]
		X_BUTTON_1,
		[CCode (cname = "sfButtonX2")]
		X_BUTTON_2, 
		
		[CCode (cname = "sfMouseButtonCount")]
		BUTTON_COUNT //Useless in Vala
	}
	
	
	[CCode (cprefix = "sfJoystickAxis")]
	public enum JoystickAxis {
		X,
		Y,
		Z,
		R,
		U,
		V,
		POVX,
		POVY,
	}
	
	
	public enum EventType {
		[CCode (cname = "sfEvtClosed")]
		CLOSED,
		[CCode (cname = "sfEvtResized")]
		RESIZED,
		[CCode (cname = "sfEvtLostFocus")]
		LOST_FOCUS,
		[CCode (cname = "sfEvtGainedFocus")]
		GAINED_FOCUS,
		[CCode (cname = "sfEvtTextEntered")]
		TEXT_ENTERED,
		[CCode (cname = "sfEvtKeyPressed")]
		KEY_PRESSED,
		[CCode (cname = "sfEvtKeyReleased")]
		KEY_RELEASED,
		[CCode (cname = "sfEvtMouseWheelMoved")]
		MOUSE_WHEEL_MOVED,
		[CCode (cname = "sfEvtMouseButtonPressed")]
		MOUSE_BUTTON_PRESSED,
		[CCode (cname = "sfEvtMouseButtonReleased")]
		MOUSE_BUTTON_RELEASED,
		[CCode (cname = "sfEvtMouseMoved")]
		MOUSE_MOVED,
		[CCode (cname = "sfEvtMouseEntered")]
		MOUSE_ENTERED,
		[CCode (cname = "sfEvtMouseLeft")]
		MOUSE_LEFT,
		[CCode (cname = "sfEvtJoyButtonPressed")]
		JOY_BUTTON_PRESSED,
		[CCode (cname = "sfEvtJoyButtonReleased")]
		JOY_BUTTON_RELEASED,
		[CCode (cname = "sfEvtJoyMoved")]
		JOY_MOVED,
		[CCode (cname = "sfEvtJoyConnected")]
		JOY_CONNECTED,
		[CCode (cname = "sfEvtJoyDisconnected")]
		JOY_DISCONNECTED
	}
	
	
	public struct KeyEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "code")]
		public KeyCode code;
		[CCode (cname = "alt")]
		public bool alt;
		[CCode (cname = "control")]
		public bool control;
		[CCode (cname = "shift")]
		public bool shift;
		[CCode (cname = "system")]
		public bool system;
	}
	
	
	public struct TextEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "unicode")]
		public uint32 unicode;
	}
	
	
	public struct MouseMoveEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "x")]
		public int x;
		[CCode (cname = "y")]
		public int y;
	}
	
	
	public struct MouseButtonEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "button")]
		public MouseButton button;
		[CCode (cname = "x")]
		public int x;
		[CCode (cname = "y")]
		public int y;
	}
	
	
	public struct MouseWheelEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "delta")]
		public int delta;
		[CCode (cname = "x")]
		public int x;
		[CCode (cname = "y")]
		public int y;
	}
	
	
	public struct JoystickMoveEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "joystickId")]
		public uint joystick_id;
		[CCode (cname = "axis")]
		public JoystickAxis axis;
		[CCode (cname = "position")]
		public float position;
	}
	
	
	public struct JoystickButtonEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "joystickId")]
		public uint joystick_id;
		[CCode (cname = "button")]
		public uint button;
	}
	
	
	public struct JoystickConnectEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "joystickId")]
		public uint joystick_id;
	}
	
	
	public struct SizeEvent {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "width")]
		public uint width;
		[CCode (cname = "height")]
		public uint height;
	}
	
	
	public struct Event {
		[CCode (cname = "type")]
		public EventType type;
		[CCode (cname = "size")]
		public SizeEvent size;
		[CCode (cname = "key")]
		public KeyEvent key;
		[CCode (cname = "text")]
		public TextEvent text;
		[CCode (cname = "mouseMove")]
		public MouseMoveEvent mouse_move;
		[CCode (cname = "mouseButton")]
		public MouseButtonEvent mouse_button;
		[CCode (cname = "mouseWheel")]
		public MouseWheelEvent mouse_wheel;
		[CCode (cname = "joyMove")]
		public JoystickMoveEvent joy_move;
		[CCode (cname = "joyButton")]
		public JoystickButtonEvent joy_button;
		[CCode (cname = "joyConnectEvent")]
		public JoystickConnectEvent joy_connect;
	}
	
	
	
	
	/*
	 * Joystick & Keyboard
	 */
	
	[SimpleType]
	public class Joystick {
		[CCode (cname = "sfJoystick_isConnected")]
		public bool is_connected (uint joystick);
		
		[CCode (cname = "sfJoystick_getButtonCount")]
		public uint get_button_count (uint joystick);
		
		[CCode (cname = "sfJoystick_hasAxis")]
		public bool has_axis (uint joystick, JoystickAxis axis);
		
		[CCode (cname = "sfJoystick_isButtonPressed")]
		public bool is_button_pressed (uint joystick, uint button);
		
		[CCode (cname = "sfJoystick_getAxisPosition")]
		public float get_axis_position (uint joystick, JoystickAxis axis);
		
		[CCode (cname = "sfJoystick_update")]
		public static void update ();
	}
	
	[SimpleType]
	public class Keyboard {
		[CCode (cname = "sfKeyboard_isKeyPressed")]
		public static bool is_key_pressed (KeyCode key);
	}
	
	[SimpleType]
	public class Mouse {
		[CCode (cname = "sfMouse_isButtonPressed")]
		public bool is_button_pressed (MouseButton button);
		
		[CCode (cname = "sfMouse_getPosition")]
		public Vector2i get_position (Window relativeTo);
		
		[CCode (cname = "sfMouse_setPosition")]
		public void set_position (Vector2i position, Window relativeTo);
	}
	
	
	
	
	/*
	 * Video mode
	 */
	
	[SimpleType]
	public struct VideoMode {
		[CCode (cname = "width")]
		public uint width;
		
		[CCode (cname = "height")]
		public uint height;
		
		[CCode (cname = "bitsPerPixel")]
		public uint bpp;
		
		[CCode (cname = "sfVideoMode_isValid")]
		public bool is_valid ();
		
		[CCode (cname = "sfVideoMode_getDesktopMode")]
		public static VideoMode get_desktop_mode ();
		
		[CCode (cname = "sfVideoMode_getFullscreenModes")]
		public static VideoMode get_fullscreen_modes ();
	}
	
	
	
	
	/*
	 * Window
	 */
	
	public enum Style {
		[CCode (cname = "sfNone")]
		NONE = 0,
		[CCode (cname = "sfTitlebar")]
		TITLE_BAR = 1 << 0,
		[CCode (cname = "sfResize")]
		RESIZE = 1 << 1,
		[CCode (cname = "sfClose")]
		CLOSE = 1 << 2,
		[CCode (cname = "sfFullscreen")]
		FULLSCREEN = 1 << 3,
		[CCode (cname = "sfDefaultStyle")]
		DEFAULT = TITLE_BAR | RESIZE | CLOSE
	}
	
	
	[CCode (cname = "sfContextSettings", has_type_id = false)]
	[SimpleType]
	public struct ContextSettings {
		[CCode (cname = "depthBits")]
		public uint depth_bits;
		[CCode (cname = "stencilBits")]
		public uint stencil_bits;
		[CCode (cname = "antialiasingLevel")]
		public uint antialiasing_level;
		[CCode (cname = "majorVersion")]
		public uint major_version;
		[CCode (cname = "minorVersion")]
		public uint minor_version;
	}
	
	
	public ContextSettings create_context_settings (uint depth_bits = 24, uint stencil_bits = 8, uint antialiasing_level = 0, uint major_version = 2, uint minor_version = 0) {
		return {depth_bits, stencil_bits, antialiasing_level, major_version, minor_version};
	}
	
	
	[CCode (cname = "sfWindow", free_function = "sfWindow_Destroy")]
	[Compact]
	public class Window {
		[CCode (cname = "sfWindow_create")]
		public Window (VideoMode mode, string title, Style style, out ContextSettings settings);
		
		[CCode (cname = "sfWindow_createUnicode")]
		public Window.create_unicode (VideoMode mode, string title, Style style, out ContextSettings settings);
		
		[CCode (cname = "sfWindow_close")]
		public void close ();
		
		[CCode (cname = "sfWindow_isOpen")]
		public bool opened ();
		
		[CCode (cname = "sfWindow_getSize")]
		public Vector2u get_size ();
		
		[CCode (cname = "sfWindow_getPosition")]
		protected Vector2i get_position ();
		
		[CCode (cname = "sfWindow_getSettings")]
		public ContextSettings get_settings ();
		
		[CCode (cname = "sfWindow_pollEvent")]
		public bool poll_event (out Event event_to_fill);
		
		[CCode (cname = "sfWindow_waitEvent")]
		public bool wait_event (out Event event_to_fill);
		
		[CCode (cname = "sfWindow_setPosition")]
		public void set_position (Vector2i position);
		
		[CCode (cname = "sfWindow_setSize")]
		public void set_size (Vector2u size);
		
		[CCode (cname = "sfWindow_setTitle")]
		public void set_title (string title);
		
		[CCode (cname = "sfWindow_setUnicodeTitle")]
		public void set_unicode_title (string title);
		
		[CCode (cname = "sfWindow_setIcon")]
		public void set_icon (uint width, uint height, uint8* pixels);
		
		[CCode (cname = "sfWindow_setVisible")]
		public void set_visible (bool show);
		
		[CCode (cname = "sfWindow_setMouseCursorVisible")]
		public void set_mouse_cursor_visible (bool show);
		
		[CCode (cname = "sfWindow_setVerticalSyncEnabled")]
		public bool set_vertical_sync_enabled (bool enable);
		
		[CCode (cname = "sfWindow_setKeyRepeatEnabled")]
		public void set_key_repeat_enabled (bool enable);
		
		[CCode (cname = "sfWindow_setActive")]
		public bool set_active (bool active = true);
		
		[CCode (cname = "sfWindow_display")]
		public void display ();
		
		[CCode (cname = "sfWindow_setFramerateLimit")]
		public void set_framerate_limit (uint limit);
		
		[CCode (cname = "sfWindow_getFrameTime")]
		public float get_frame_time ();
		
		[CCode (cname = "sfWindow_setJoystickThreshold")]
		public void set_joystick_threshold (float threshold);
	}
}
