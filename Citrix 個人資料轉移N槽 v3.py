# 確認資料夾用
import os
# 調用修改Regedit
import win32api
import win32con

# 視窗大小設定
os.system('mode con: cols=30 lines=10')

# 輸入設定工號資料夾
Num = input("請輸入您的工號: ")
NumFolder = "N:/U/" + Num
print()# 空格讓版型好看

# 讀取註冊檔
reg = win32api.RegOpenKey(win32con.HKEY_CURRENT_USER, 'SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders', 0, win32con.KEY_ALL_ACCESS)
reg2 = win32api.RegOpenKey(win32con.HKEY_CURRENT_USER, 'SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders', 0, win32con.KEY_ALL_ACCESS)

# 修改登入檔副程式
def set_reg(reg, reg_name, reg_type, reg_value):
    """
    作用: 設定註冊檔
    參數0: 註冊檔
    參數1: 設置項的名字
    參數2: 設置項的類型
    參數3: 設置項值
    """
    win32api.RegSetValueEx(reg, reg_name, 0, reg_type, reg_value)

# 設定註冊檔
# set_reg(reg, "UpdateDefault", win32con.REG_DWORD, 0)
# set_reg(reg, "Python", win32con.REG_SZ, "測試")


# 確認資料夾是否正確後運行
if os.path.exists(NumFolder):
    print("資料夾存在，進行修改動作。")
    print()# 空格讓版型好看

    # 建立轉移資料夾目錄
    if not os.path.isdir(NumFolder + "/Citrix Profile"):
        os.mkdir(NumFolder + "/Citrix Profile")
    if not os.path.isdir(NumFolder + "/Citrix Profile/Downloads"):
        os.mkdir(NumFolder + "/Citrix Profile/Downloads")
    if not os.path.isdir(NumFolder + "/Citrix Profile/Music"):
        os.mkdir(NumFolder + "/Citrix Profile/Music")
    if not os.path.isdir(NumFolder + "/Citrix Profile/Pictures"):
        os.mkdir(NumFolder + "/Citrix Profile/Pictures")
    if not os.path.isdir(NumFolder + "/Citrix Profile/Videos"):
        os.mkdir(NumFolder + "/Citrix Profile/Videos")
    if not os.path.isdir(NumFolder + "/Citrix Profile/Documents"):
        os.mkdir(NumFolder + "/Citrix Profile/Documents")
    
    # 調用副程式
    set_reg(reg, "{374DE290-123F-4565-9164-39C4925E467B}", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Downloads")
    set_reg(reg, "My Music", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Music")
    set_reg(reg, "My Pictures", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Pictures")
    set_reg(reg, "My Video", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Videos")
    set_reg(reg, "Personal", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Documents")

    set_reg(reg2, "{0DDD015D-B06C-45D5-8C4C-F59713854639}", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Pictures")
    set_reg(reg2, "{35286A68-3C57-41A1-BBB1-0EAE73D76C95}", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Videos")
    set_reg(reg2, "{374DE290-123F-4565-9164-39C4925E467B}", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Downloads")
    set_reg(reg2, "{7D83EE9B-2244-4E70-B1F5-5393042AF1E4}", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Downloads")
    set_reg(reg2, "{A0C69A99-21C8-4671-8703-7934162FCF1D}", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Music")
    set_reg(reg2, "{F42EE2D3-909F-4907-8871-4C22FC0BF756}", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Documents")
    set_reg(reg2, "My Music", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Music")
    set_reg(reg2, "My Pictures", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Pictures")
    set_reg(reg2, "My Video", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Videos")
    set_reg(reg2, "Personal", win32con.REG_SZ, "N:\\U\\" + Num + "\\Citrix Profile\\Documents")
    os.system('pause')
else:
    print("資料夾不存在，請確認輸入是否正確。")
    print()# 空格讓版型好看
    os.system('pause')