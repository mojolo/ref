# https://unix.stackexchange.com/questions/5999/setting-the-window-dimensions-of-a-running-application
# https://stackoverflow.com/questions/76570831/how-to-get-the-position-of-an-active-window
import Xlib.display
import subprocess


win_id = ''
zoom_h = 1320
zoom_w = 1496
zoom_x = 972
zoom_y = 78
zoom_2w = 2420
zoom_2x = 510
reset_w = 1163
reset_h = 1243
reset_x = 1104
reset_y = 78


def reset_vscode():
    vscode_w = reset_w + 73
    vscode_x = reset_x + 102
    vscode_y = reset_y - 12
    subprocess.run(["wmctrl", "-i", "-r", f'{win_id}', f'-e 0,{vscode_x},{vscode_y},{vscode_w},{reset_h}'])


def reset_pycharm():
    pyc_w = reset_w + 300
    pyc_h = reset_h + 96
    pyc_x = reset_x + 659
    pyc_y = reset_y - 12
    subprocess.run(["wmctrl", "-i", "-r", f'{win_id}', f'-e 0,{pyc_x},{pyc_y},{pyc_w},{pyc_h}'])


def reset_kate():
    kate_y = reset_y + 119
    subprocess.run(["wmctrl", "-i", "-r", f'{win_id}', f'-e 0,{reset_x},{kate_y},{reset_w},{reset_h}'])


def reset_ktty():
    subprocess.run(["wmctrl", "-i", "-r", f'{win_id}', f'-e 0,0,738,1104,693'])


def center_window():
    disp = Xlib.display.Display()
    win_class = disp.get_input_focus().focus.get_wm_class()
    root = disp.screen().root
    global win_id
    win_id = root.get_full_property(disp.intern_atom('_NET_ACTIVE_WINDOW'), Xlib.X.AnyPropertyType).value[0]
    win = disp.create_resource_object('window', win_id)
    geom = win.get_geometry()
    pos = geom.root.translate_coords(win.id, 0, 0)
    h = geom.height
    w = geom.width
    x = pos.x
    y = pos.y

    if w < zoom_w or w >= zoom_2w:
        if win_class[1] == "kate":
            subprocess.run(["wmctrl", "-i", "-r", f'{win_id}', f'-e 0,{zoom_x},{zoom_y + 33},{zoom_w},{zoom_h}'])
        elif win_class[1] == "ktty":
            subprocess.run(["wmctrl", "-i", "-r", f'{win_id}', f'-e 0,{zoom_x},{zoom_y},{zoom_w},{zoom_h + 34}'])
        elif win_class[1] == "FocusProxy" or win_class[1] == "Code":
            subprocess.run(["wmctrl", "-i", "-r", f'{win_id}', f'-e 0,{zoom_x},{zoom_y},{zoom_w},{zoom_h}'])
    elif win_class[1] == "kate":
        reset_kate()
    elif win_class[1] == "Code":
        reset_vscode()
    elif win_class[1] == "ktty":
        reset_ktty()
    elif win_class[1] == "FocusProxy":
        reset_pycharm()


center_window()
