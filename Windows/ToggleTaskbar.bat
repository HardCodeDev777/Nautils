<# :
@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((Get-Content '%~f0' | Out-String))"
exit /b
#>

$code = @"
using System;
using System.Runtime.InteropServices;

public class TaskbarToggle {
    [StructLayout(LayoutKind.Sequential)]
    public struct RECT {
        public int left, top, right, bottom;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct APPBARDATA {
        public int cbSize;
        public IntPtr hWnd;
        public int uCallbackMessage;
        public int uEdge;
        public RECT rc;
        public IntPtr lParam;
    }

    [DllImport("shell32.dll")]
    public static extern IntPtr SHAppBarMessage(int dwMessage, ref APPBARDATA pData);

    public static void Toggle() {
        APPBARDATA abd = new APPBARDATA();
        abd.cbSize = Marshal.SizeOf(typeof(APPBARDATA));

        // 4 = ABM_GETSTATE
        IntPtr state = SHAppBarMessage(4, ref abd);

        // 10 = ABM_SETSTATE
        // 1 = ABS_AUTOHIDE, 2 = ABS_ALWAYSONTOP
        if (((long)state & 1) == 1) {
            abd.lParam = (IntPtr)2; // Выключить автоскрытие (закрепить)
        } else {
            abd.lParam = (IntPtr)1; // Включить автоскрытие (спрятать)
        }
        SHAppBarMessage(10, ref abd);
    }
}
"@

Add-Type -TypeDefinition $code
[TaskbarToggle]::Toggle()