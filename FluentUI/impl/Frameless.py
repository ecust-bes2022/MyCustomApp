import ctypes
import sys

from PySide6.QtCore import Signal, Slot, Qt, QPoint, QEvent, QAbstractNativeEventFilter, Property, QRectF, QDateTime, \
    QPointF, QSize
from PySide6.QtGui import QMouseEvent, QGuiApplication, QCursor, QWindow
from PySide6.QtQml import QmlElement
from PySide6.QtQuick import QQuickItem

if sys.platform.startswith("darwin"):
    from FluentUI.impl.OSXHideTitleBar import hide_title_bar

from FluentUI.impl.Tools import Tools

if sys.platform.startswith("win"):
    from ctypes import POINTER, byref, c_int, c_void_p, c_long, WinDLL, POINTER, Structure, c_short
    from ctypes.wintypes import DWORD, HWND, MSG, RECT, UINT, POINT, RECTL, LPCVOID, WCHAR, HMONITOR, WPARAM, LPARAM, \
        BOOL, HMENU, SHORT, LPPOINT, LPRECT, HDC, INT, LPCWSTR


    class MARGINS(Structure):
        _fields_ = [
            ("cxLeftWidth", c_int),
            ("cxRightWidth", c_int),
            ("cyTopHeight", c_int),
            ("cyBottomHeight", c_int),
        ]


    class PWINDOWPOS(Structure):
        _fields_ = [
            ('hWnd', HWND),
            ('hwndInsertAfter', HWND),
            ('x', c_int),
            ('y', c_int),
            ('cx', c_int),
            ('cy', c_int),
            ('flags', UINT)
        ]


    class NCCALCSIZE_PARAMS(Structure):
        _fields_ = [
            ('rgrc', RECT * 3),
            ('lppos', POINTER(PWINDOWPOS))
        ]


    class APPBARDATA(ctypes.Structure):
        _fields_ = [
            ("cbSize", UINT),
            ("hWnd", HWND),
            ("uCallbackMessage", UINT),
            ("uEdge", UINT),
            ("rc", RECT),
            ("lParam", LPARAM)
        ]


    class MINMAXINFO(Structure):
        _fields_ = [
            ("ptReserved", POINT),
            ("ptMaxSize", POINT),
            ("ptMaxPosition", POINT),
            ("ptMinTrackSize", POINT),
            ("ptMaxTrackSize", POINT),
        ]


    class MONITORINFOEXW(ctypes.Structure):
        _fields_ = [
            ("cbSize", DWORD),
            ("rcMonitor", RECT),
            ("rcWork", RECT),
            ("dwFlags", DWORD),
            ("szDevice", WCHAR * 32)
        ]


    class WINDOWPLACEMENT(ctypes.Structure):
        _fields_ = [
            ("length", UINT),
            ("flags", UINT),
            ("showCmd", UINT),
            ("ptMinPosition", POINT),
            ("ptMaxPosition", POINT),
            ("rcNormalPosition", RECT)
        ]


    LPNCCALCSIZE_PARAMS = POINTER(NCCALCSIZE_PARAMS)
    qtNativeEventType = b"windows_generic_MSG"
    user32 = WinDLL("user32")
    dwmapi = WinDLL("dwmapi")
    gdi32 = WinDLL('gdi32')
    shell32 = WinDLL('shell32')

    GetDC = user32.GetDC
    GetDC.argtypes = [HWND]
    GetDC.restype = HDC

    SHAppBarMessage = shell32.SHAppBarMessage
    SHAppBarMessage.argtypes = [DWORD, ctypes.POINTER(APPBARDATA)]
    SHAppBarMessage.restype = UINT

    GetDpiForWindow = user32.GetDpiForWindow
    GetDpiForWindow.argtypes = [HWND]
    GetDpiForWindow.restype = UINT

    FindWindowW = user32.FindWindowW
    FindWindowW.argtypes = [LPCWSTR, LPCWSTR]
    FindWindowW.restype = HWND

    GetWindowPlacement = user32.GetWindowPlacement
    GetWindowPlacement.argtypes = [HWND, ctypes.POINTER(WINDOWPLACEMENT)]
    GetWindowPlacement.restype = BOOL

    GetDeviceCaps = gdi32.GetDeviceCaps
    GetDeviceCaps.argtypes = [HDC, INT]
    GetDeviceCaps.restype = INT

    ReleaseDC = user32.ReleaseDC
    ReleaseDC.argtypes = [HWND, HDC]
    ReleaseDC.restype = INT

    GetSystemMetricsForDpi = user32.GetSystemMetricsForDpi
    GetSystemMetricsForDpi.argtypes = [INT, UINT]
    GetSystemMetricsForDpi.restype = INT

    GetSystemMetrics = user32.GetSystemMetrics
    GetSystemMetrics.argtypes = [INT]
    GetSystemMetrics.restype = INT

    GetWindowRect = user32.GetWindowRect
    GetWindowRect.argtypes = [HWND, POINTER(RECT)]
    GetWindowRect.restype = BOOL

    MonitorFromWindow = user32.MonitorFromWindow
    MonitorFromWindow.argtypes = [HWND, DWORD]
    MonitorFromWindow.restype = HMONITOR

    GetMonitorInfoW = user32.GetMonitorInfoW
    GetMonitorInfoW.argtypes = [HMONITOR, ctypes.POINTER(MONITORINFOEXW)]
    GetMonitorInfoW.restype = BOOL

    PostMessageW = user32.PostMessageW
    PostMessageW.argtypes = [HWND, UINT, WPARAM, LPARAM]
    PostMessageW.restype = BOOL

    TrackPopupMenu = user32.TrackPopupMenu
    TrackPopupMenu.argtypes = [HMENU, UINT, c_int, c_int, c_int, HWND, c_void_p]
    TrackPopupMenu.restype = BOOL

    EnableMenuItem = user32.EnableMenuItem
    EnableMenuItem.argtypes = [HMENU, UINT, UINT]
    EnableMenuItem.restype = BOOL

    GetSystemMenu = user32.GetSystemMenu
    GetSystemMenu.argtypes = [HMENU, BOOL]
    GetSystemMenu.restype = HMENU

    GetKeyState = user32.GetKeyState
    GetKeyState.argtypes = [c_int]
    GetKeyState.restype = SHORT

    ScreenToClient = user32.ScreenToClient
    ScreenToClient.argtypes = [HWND, LPPOINT]
    ScreenToClient.restype = BOOL

    GetClientRect = user32.GetClientRect
    GetClientRect.argtypes = [HWND, LPRECT]
    GetClientRect.restype = BOOL

    SetWindowPos = user32.SetWindowPos
    SetWindowPos.argtypes = [HWND, HWND, c_int, c_int, c_int, c_int, UINT]
    SetWindowPos.restype = BOOL

    GetWindowLongPtrW = user32.GetWindowLongPtrW
    GetWindowLongPtrW.argtypes = [HWND, c_int]
    GetWindowLongPtrW.restype = c_long

    SetWindowLongPtrW = user32.SetWindowLongPtrW
    SetWindowLongPtrW.argtypes = [HWND, c_int, c_long]
    SetWindowLongPtrW.restype = c_long

    IsZoomed = user32.IsZoomed
    IsZoomed.argtypes = [HWND]
    IsZoomed.restype = BOOL

    DefWindowProcW = user32.DefWindowProcW
    DefWindowProcW.argtypes = [HWND, UINT, WPARAM, LPARAM]
    DefWindowProcW.restype = c_long

    DwmIsCompositionEnabled = dwmapi.DwmIsCompositionEnabled
    DwmIsCompositionEnabled.argtypes = [HWND]
    DwmIsCompositionEnabled.restype = c_long

    DwmExtendFrameIntoClientArea = dwmapi.DwmExtendFrameIntoClientArea
    DwmExtendFrameIntoClientArea.argtypes = [HWND, c_void_p]
    DwmExtendFrameIntoClientArea.restype = c_long

    DwmSetWindowAttribute = dwmapi.DwmSetWindowAttribute
    DwmSetWindowAttribute.argtypes = [c_int, DWORD, LPCVOID, DWORD]
    DwmSetWindowAttribute.restype = c_long


    def LOWORD(dwValue):
        return int(dwValue) & 0xffff


    def HIWORD(dwValue):
        return (int(dwValue) >> 16) & 0xffff


    def GET_X_LPARAM(lp):
        return c_short(LOWORD(lp)).value


    def GET_Y_LPARAM(lp):
        return c_short(HIWORD(lp)).value


    def isCompositionEnabled():
        bResult = c_int(0)
        dwmapi.DwmIsCompositionEnabled(byref(bResult))
        return bool(bResult.value)


    def getMonitorForWindow(hwnd):
        if not hwnd:
            return None
        monitor = MonitorFromWindow(hwnd, 0x00000002)
        if not monitor:
            return None
        monitor_info = MONITORINFOEXW()
        monitor_info.cbSize = ctypes.sizeof(MONITORINFOEXW)
        if not GetMonitorInfoW(monitor, ctypes.byref(monitor_info)):
            return None
        return monitor_info


    def isFullScreen(hwnd):
        window_rect = RECT()
        if not GetWindowRect(hwnd, ctypes.byref(window_rect)):
            return False
        monitor_info = getMonitorForWindow(hwnd)
        if monitor_info is None:
            return False
        rc_monitor = monitor_info.rcMonitor
        return (window_rect.top == rc_monitor.top and
                window_rect.left == rc_monitor.left and
                window_rect.right == rc_monitor.right and
                window_rect.bottom == rc_monitor.bottom)


    def isMaximized(hwnd):
        wp = WINDOWPLACEMENT()
        wp.length = ctypes.sizeof(WINDOWPLACEMENT)
        user32.GetWindowPlacement(hwnd, ctypes.byref(wp))
        return wp.showCmd == 3


    def getDpiForWindow(hwnd, horizontal: bool) -> int:
        dpi = GetDpiForWindow(hwnd)
        if dpi:
            return dpi
        hdc = GetDC(hwnd)
        if hdc:
            dpiX = GetDeviceCaps(hdc, 88)
            dpiY = GetDeviceCaps(hdc, 90)
            ReleaseDC(hwnd, hdc)
            if dpiX > 0 and dpiY > 0:
                return dpiX if horizontal else dpiY
        return 96


    def getSystemMetrics(hwnd, index: int, horizontal: bool) -> int:
        dpi = getDpiForWindow(hwnd, horizontal)
        result = GetSystemMetricsForDpi(index, dpi)
        if result > 0:
            return result
        return GetSystemMetrics(index)


    def getResizeBorderThickness(hwnd, horizontal: bool, device_pixel_ratio: float) -> int:
        frame = 32 if horizontal else 33
        result = getSystemMetrics(hwnd, frame, horizontal) + getSystemMetrics(hwnd, 92, horizontal)
        if result > 0:
            return result
        thickness = 8 if isCompositionEnabled() else 4
        return round(thickness * device_pixel_ratio)


    def setWindowEffect(hwnd, effectType):
        margins = MARGINS(1, 1, 0, 1)
        if effectType == 1:
            DwmExtendFrameIntoClientArea(hwnd, byref(margins))
            system_backdrop_type = c_int(2)
            DwmSetWindowAttribute(hwnd, 38, byref(system_backdrop_type), ctypes.sizeof(c_int))
        elif effectType == 2:
            DwmExtendFrameIntoClientArea(hwnd, byref(margins))
            system_backdrop_type = c_int(3)
            DwmSetWindowAttribute(hwnd, 38, byref(system_backdrop_type), ctypes.sizeof(c_int))
        else:
            DwmExtendFrameIntoClientArea(hwnd, byref(margins))

QML_IMPORT_NAME = "FluentUI.impl"
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_MINOR_VERSION = 0


@QmlElement
class Frameless(QQuickItem, QAbstractNativeEventFilter):
    appbarChanged = Signal()
    topmostChanged = Signal()
    buttonMaximizedChanged = Signal()
    disabledChanged = Signal()
    fixSizeChanged = Signal()
    darkChanged = Signal()
    windowEffectChanged = Signal()

    def __init__(self, parent=None):
        QQuickItem.__init__(self, parent)
        QAbstractNativeEventFilter.__init__(self, parent)
        self.__current: int = 0
        self.__edges: int = 0
        self.__margins: int = 8
        self.__clickTimer: int = 0
        self.__hitTestList: list[QQuickItem] = []
        self.__appbar = None
        self.__dark: bool = False
        self.__topmost: bool = False
        self.__disabled: bool = False
        self.__fixSize: bool = False
        self.__buttonMaximized = None
        self.__windowEffect = 0
        self.__isWindows11OrGreater = Tools().isWindows11OrGreater()

    @Property(int, notify=windowEffectChanged)
    def windowEffect(self):
        return self.__windowEffect

    @windowEffect.setter
    def windowEffect(self, value):
        if self.__windowEffect == value:
            return
        self.__windowEffect = value
        self.windowEffectChanged.emit()

    @Property(bool, notify=darkChanged)
    def dark(self):
        return self.__dark

    @dark.setter
    def dark(self, value):
        if self.__dark == value:
            return
        self.__dark = value
        self.darkChanged.emit()

    @Property(QQuickItem, notify=appbarChanged)
    def appbar(self):
        return self.__appbar

    @appbar.setter
    def appbar(self, value):
        if self.__appbar == value:
            return
        self.__appbar = value
        self.appbarChanged.emit()

    @Property(bool, notify=topmostChanged)
    def topmost(self):
        return self.__topmost

    @topmost.setter
    def topmost(self, value):
        if self.__topmost == value:
            return
        self.__topmost = value
        self.topmostChanged.emit()

    @Property(QQuickItem, notify=buttonMaximizedChanged)
    def buttonMaximized(self):
        return self.__buttonMaximized

    @buttonMaximized.setter
    def buttonMaximized(self, value):
        if self.__buttonMaximized == value:
            return
        self.__buttonMaximized = value
        self.buttonMaximizedChanged.emit()

    @Property(bool, notify=disabledChanged)
    def disabled(self):
        return self.__disabled

    @disabled.setter
    def disabled(self, value):
        if self.__disabled == value:
            return
        self.__disabled = value
        self.disabledChanged.emit()

    @Property(bool, notify=fixSizeChanged)
    def fixSize(self):
        return self.__fixSize

    @fixSize.setter
    def fixSize(self, value):
        if self.__fixSize == value:
            return
        self.__fixSize = value
        self.fixSizeChanged.emit()

    @Slot()
    def onDestruction(self):
        QGuiApplication.instance().removeNativeEventFilter(self)

    def componentComplete(self):
        if self.__disabled:
            return
        w = self.window().width()
        h = self.window().height()
        self.__current = self.window().winId()
        self.window().installEventFilter(self)
        QGuiApplication.instance().installNativeEventFilter(self)
        if sys.platform.startswith("darwin"):
            hide_title_bar(self.__current)
        if sys.platform.startswith("linux"):
            self.window().setFlag(Qt.WindowType.CustomizeWindowHint, True)
            self.window().setFlag(Qt.WindowType.FramelessWindowHint, True)
            self.window().setProperty("__borderWidth", 1)
        if self.__buttonMaximized is not None:
            self.setHitTestVisible(self.__buttonMaximized)
        if sys.platform.startswith("win"):
            self.window().setFlag(Qt.WindowType.CustomizeWindowHint, True)
            hwnd = self.window().winId()
            style: DWORD = GetWindowLongPtrW(hwnd, -16)
            if self.__fixSize:
                SetWindowLongPtrW(hwnd, -16, style | 0x00040000 | 0x00C00000 | 0x00020000)
            else:
                SetWindowLongPtrW(hwnd, -16, style | 0x00010000 | 0x00040000 | 0x00C00000 | 0x00020000)
            SetWindowPos(hwnd, None, 0, 0, 0, 0, 0x0004 | 0x0200 | 0x0002 | 0x0001 | 0x0020)
            if not self.window().property("__windowEffectDisabled"):
                setWindowEffect(hwnd, self.__windowEffect)
            self.darkChanged.connect(self, lambda: self.__setWindowDark(self.__dark))
            self.windowEffectChanged.connect(self, lambda: setWindowEffect(hwnd, self.__windowEffect))
        appBarHeight = 0
        if self.__appbar is not None:
            appBarHeight = self.__appbar.height()
        h = int(h + appBarHeight)
        if self.__fixSize:
            self.window().setMinimumSize(QSize(w, h))
            self.window().setMaximumSize(QSize(w, h))
        else:
            self.window().setMinimumHeight(self.window().minimumHeight() + appBarHeight)
            self.window().setMaximumHeight(self.window().maximumHeight() + appBarHeight)
        self.window().resize(w, h)
        self.topmostChanged.connect(self, lambda: self.__setWindowTopmost(self.__topmost))
        self.__setWindowTopmost(self.__topmost)
        self.__setWindowDark(self.__dark)

    def nativeEventFilter(self, eventType, message):
        if not sys.platform.startswith("win"):
            return False
        if eventType != qtNativeEventType or message is None:
            return False
        msg = MSG.from_address(message.__int__())
        hwnd = msg.hWnd
        if hwnd is None and msg is None:
            return False
        if hwnd != self.__current:
            return False
        uMsg = msg.message
        wParam = msg.wParam
        lParam = msg.lParam
        if uMsg == 0x0083 and wParam == 1:
            clientRect = ctypes.cast(lParam, POINTER(NCCALCSIZE_PARAMS)).contents.rgrc[0]
            isMax = isMaximized(hwnd)
            isFull = isFullScreen(hwnd)
            if isMax and not isFull:
                ty = getResizeBorderThickness(hwnd, False, self.window().devicePixelRatio())
                clientRect.top += ty
                clientRect.bottom -= ty
                tx = getResizeBorderThickness(hwnd, True, self.window().devicePixelRatio())
                clientRect.left += tx
                clientRect.right -= tx
            if isMax or isFull:
                abd = APPBARDATA()
                ctypes.memset(ctypes.byref(abd), 0, ctypes.sizeof(abd))
                abd.cbSize = ctypes.sizeof(APPBARDATA)
                taskbarState = SHAppBarMessage(0x00000004, ctypes.byref(abd))
                if taskbarState & 0x0000001:
                    edge = -1
                    abd2 = APPBARDATA()
                    ctypes.memset(ctypes.byref(abd2), 0, ctypes.sizeof(abd2))
                    abd2.cbSize = ctypes.sizeof(APPBARDATA)
                    abd2.hWnd = FindWindowW("Shell_TrayWnd", None)
                    if abd2.hWnd:
                        windowMonitor = MonitorFromWindow(hwnd, 0x00000002)
                        if windowMonitor:
                            taskbarMonitor = MonitorFromWindow(abd2.hWnd, 0x00000001)
                            if taskbarMonitor and taskbarMonitor == windowMonitor:
                                SHAppBarMessage(0x00000005, ctypes.byref(abd2))
                                edge = abd2.uEdge
                    top = (edge == 1)
                    bottom = (edge == 3)
                    left = (edge == 0)
                    right = (edge == 2)
                    if top:
                        clientRect.top += 1
                    elif bottom:
                        clientRect.bottom -= 1
                    elif left:
                        clientRect.left += 1
                    elif right:
                        clientRect.right -= 1
                    else:
                        clientRect.bottom -= 1
                else:
                    if isFull and self.__isWindows11OrGreater:
                        clientRect.bottom += 1
            return True, 0
        elif uMsg == 0x0084:
            if self.__isWindows11OrGreater:
                if self.__hitMaximizeButton():
                    self.__setMaximizeHovered(True)
                    return True, 9
                self.__setMaximizeHovered(False)
                self.__setMaximizePressed(False)
            nativeGlobalPos = POINT(GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam))
            nativeLocalPos = POINT(nativeGlobalPos.x, nativeGlobalPos.y)
            ScreenToClient(hwnd, byref(nativeLocalPos))
            clientRect = RECTL(0, 0, 0, 0)
            GetClientRect(hwnd, byref(clientRect))
            clientWidth = clientRect.right - clientRect.left
            clientHeight = clientRect.bottom - clientRect.top
            left = nativeLocalPos.x < self.__margins
            right = nativeLocalPos.x > clientWidth - self.__margins
            top = nativeLocalPos.y < self.__margins
            bottom = nativeLocalPos.y > clientHeight - self.__margins
            result = 0
            if not self.__fixSize and not self.__isFullScreen() and not self.__isMaximized():
                if left and top:
                    result = 13
                elif left and bottom:
                    result = 16
                elif right and top:
                    result = 14
                elif right and bottom:
                    result = 17
                elif left:
                    result = 10
                elif right:
                    result = 11
                elif top:
                    result = 12
                elif bottom:
                    result = 15
            if result != 0:
                return True, result
            if self.__hitAppBar():
                return True, 2
            return True, 1
        elif uMsg == 0x0085:
            if isCompositionEnabled() and not self.__isFullScreen():
                return False, 0
            return True, 1
        elif uMsg == 0x0086:
            if isCompositionEnabled():
                return False, 0
            return True, 1
        elif self.__isWindows11OrGreater and (uMsg == 0x00A3 or uMsg == 0x00A1):
            if self.__hitMaximizeButton():
                event = QMouseEvent(QEvent.Type.MouseButtonPress, QPoint(), QPoint(), Qt.MouseButton.LeftButton,
                                    Qt.MouseButton.LeftButton, Qt.KeyboardModifier.NoModifier)
                QGuiApplication.instance().sendEvent(self.__buttonMaximized, event)
                self.__setMaximizePressed(True)
                return True, 0
        elif self.__isWindows11OrGreater and (uMsg == 0x00A2 or uMsg == 0x00A5):
            if self.__hitMaximizeButton():
                event = QMouseEvent(QEvent.Type.MouseButtonRelease, QPoint(), QPoint(), Qt.MouseButton.LeftButton,
                                    Qt.MouseButton.LeftButton, Qt.KeyboardModifier.NoModifier)
                QGuiApplication.instance().sendEvent(self.__buttonMaximized, event)
                self.__setMaximizePressed(False)
                return True, 0
        elif uMsg == 0x00A4:
            if wParam == 2:
                pos = self.window().position()
                offset = self.window().mapFromGlobal(QCursor.pos())
                self.__showSystemMenu(QPoint(pos.x() + offset.x(), pos.y() + offset.y()))
                return True, 0
        elif uMsg == 0x0100 or uMsg == 0x0104:
            altPressed = (wParam == 0x12) or (GetKeyState(0x12) < 0)
            spacePressed = (wParam == 0x20) or (GetKeyState(0x20) < 0)
            if altPressed and spacePressed:
                pos = self.window().position()
                self.__showSystemMenu(QPoint(pos.x(), int(pos.y() + self.__appbar.height())))
                return True, 0
        return False, 0

    def __setWindowDark(self, dark: bool):
        if sys.platform.startswith("win"):
            value = c_int(dark)
            hwnd = self.window().winId()
            return DwmSetWindowAttribute(hwnd, 20, byref(value), ctypes.sizeof(c_int))
        return False

    def __showSystemMenu(self, point: QPoint):
        if sys.platform.startswith("win"):
            screen = self.window().screen()
            if not screen:
                screen = QGuiApplication.primaryScreen()
            if not screen:
                return
            origin = screen.geometry().topLeft()
            nativePos = QPointF(QPointF(point - origin) * self.window().devicePixelRatio()).toPoint() + origin
            hwnd = self.window().winId()
            hMenu = GetSystemMenu(hwnd, False)
            if self.__isMaximized() or self.__isFullScreen():
                EnableMenuItem(hMenu, 0xF010, 0x00000003)
                EnableMenuItem(hMenu, 0xF120, 0x00000000)
            else:
                EnableMenuItem(hMenu, 0xF010, 0x00000000)
                EnableMenuItem(hMenu, 0xF120, 0x00000003)

            if (not self.__fixSize) and (not self.__isMaximized()) and (not self.__isFullScreen()):
                EnableMenuItem(hMenu, 0xF000, 0x00000000)
                EnableMenuItem(hMenu, 0xF030, 0x00000000)
            else:
                EnableMenuItem(hMenu, 0xF000, 0x00000003)
                EnableMenuItem(hMenu, 0xF030, 0x00000003)
            EnableMenuItem(hMenu, 0xF060, 0x00000000)
            result = TrackPopupMenu(hMenu, (0x0100 | (0x0008 if QGuiApplication.isRightToLeft() else 0x0000)),
                                    nativePos.x(),
                                    nativePos.y(), 0, hwnd, 0)
            if result:
                PostMessageW(hwnd, 0x0112, result, 0)

    def eventFilter(self, watched, event):
        if sys.platform.startswith("darwin"):
            if event.type() == QEvent.Type.MouseButtonPress:
                if self.__hitAppBar():
                    clickTimer = QDateTime.currentMSecsSinceEpoch()
                    offset = clickTimer - self.__clickTimer
                    self.__clickTimer = clickTimer
                    if offset < 300:
                        if self.__isMaximized():
                            self.showNormal()
                        else:
                            self.showMaximized()
                    else:
                        self.window().startSystemMove()
        elif sys.platform.startswith("linux"):
            if event.type() == QEvent.Type.MouseButtonPress:
                if self.__edges != 0:
                    mouse_event = QMouseEvent(event)
                    if mouse_event.button() == Qt.MouseButton.LeftButton:
                        self.__updateCursor(self.__edges)
                        self.window().startSystemResize(Qt.Edge(self.__edges))
                else:
                    if self.__hitAppBar():
                        clickTimer = QDateTime.currentMSecsSinceEpoch()
                        offset = clickTimer - self.__clickTimer
                        self.__clickTimer = clickTimer
                        if offset < 300:
                            if self.__isMaximized():
                                self.showNormal()
                            else:
                                self.showMaximized()
                        else:
                            self.window().startSystemMove()
            elif event.type() == QEvent.Type.MouseButtonRelease:
                self.__edges = 0
            elif event.type() == QEvent.Type.MouseMove:
                if self.__isMaximized() or self.__isFullScreen():
                    return False
                if self.__fixSize:
                    return False
                mouse_event = QMouseEvent(event)
                p = mouse_event.position().toPoint()
                if self.__margins <= p.x() <= (self.window().width() - self.__margins) and self.__margins <= p.y() <= (
                        self.window().height() - self.__margins):
                    if self.__edges != 0:
                        self.__edges = 0
                        self.__updateCursor(self.__edges)
                    return False
                self.__edges = 0
                if p.x() < self.__margins:
                    self.__edges |= 0x00002
                if p.x() > (self.window().width() - self.__margins):
                    self.__edges |= 0x00004
                if p.y() < self.__margins:
                    self.__edges |= 0x00001
                if p.y() > (self.window().height() - self.__margins):
                    self.__edges |= 0x00008
                self.__updateCursor(self.__edges)
        return False

    @Slot()
    def showFullScreen(self):
        self.window().showFullScreen()

    @Slot()
    def showMaximized(self):
        if sys.platform.startswith("win"):
            hwnd = self.window().winId()
            user32.ShowWindow(hwnd, 3)
        else:
            self.window().showMaximized()

    @Slot()
    def showMinimized(self):
        if sys.platform.startswith("win"):
            hwnd = self.window().winId()
            user32.ShowWindow(hwnd, 2)
        else:
            self.window().showMinimized()

    @Slot()
    def showNormal(self):
        self.window().showNormal()

    @Slot(QQuickItem)
    def setHitTestVisible(self, val: QQuickItem):
        self.__hitTestList.append(val)

    def __containsCursorToItem(self, item: QQuickItem):
        try:
            if not item or not item.isVisible():
                return False
            point = item.window().mapFromGlobal(QCursor.pos())
            rect = QRectF(item.mapToItem(item.window().contentItem(), QPointF(0, 0)), item.size())
            if rect.contains(point):
                return True
        except RuntimeError:
            self.__hitTestList.remove(item)
            return False
        return False

    def __isFullScreen(self):
        return self.window().visibility() == QWindow.Visibility.FullScreen

    def __isMaximized(self):
        return self.window().visibility() == QWindow.Visibility.Maximized

    def __updateCursor(self, edges: int):
        if edges == 0:
            self.window().setCursor(Qt.CursorShape.ArrowCursor)
        elif edges == 0x00002 or edges == 0x00004:
            self.window().setCursor(Qt.CursorShape.SizeHorCursor)
        elif edges == 0x00001 or edges == 0x00008:
            self.window().setCursor(Qt.CursorShape.SizeVerCursor)
        elif edges == 0x00002 | 0x00001 or edges == 0x00004 | 0x00008:
            self.window().setCursor(Qt.CursorShape.SizeFDiagCursor)
        elif edges == 0x00004 | 0x00001 or edges == 0x00002 | 0x00008:
            self.window().setCursor(Qt.CursorShape.SizeBDiagCursor)

    def __setWindowTopmost(self, topmost: bool):
        if sys.platform.startswith("win"):
            if topmost:
                SetWindowPos(self.window().winId(), -1, 0, 0, 0, 0, 0x0002 | 0x0001)
            else:
                SetWindowPos(self.window().winId(), -2, 0, 0, 0, 0, 0x0002 | 0x0001)
        else:
            self.window().setFlag(Qt.WindowType.WindowStaysOnTopHint, topmost)

    def __setMaximizeHovered(self, val):
        self.__buttonMaximized.setProperty("hover", val)

    def __setMaximizePressed(self, val):
        self.__buttonMaximized.setProperty("down", val)

    def __hitAppBar(self):
        for item in self.__hitTestList:
            if self.__containsCursorToItem(item):
                return False
        if self.__containsCursorToItem(self.__appbar):
            return True
        return False

    def __hitMaximizeButton(self):
        if self.__containsCursorToItem(self.__buttonMaximized):
            return True
        return False
