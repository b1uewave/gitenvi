#!/bin/bash
# ==============================================================================
#           Custom Development Helper Functions for Shell (Final Version)
#
# 檔案路徑: /Users/chying/Documents/AIAgent/setup-github/github_helpers.sh
# ==============================================================================


#
# new-proj()
# 功能: 自動建立新專案。
#
new-proj() {
    # 檢查是否提供了足夠的參數
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "使用方式: new-proj <account_name> <project_name>"
        echo "支援的帳號: febedev, alfiegbc, b1uewave, chying1219"
        return 1
    fi

    # 將帳號名稱統一轉為小寫，以便比對
    local account_name=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local project_name="$2"
    # 您的專案根目錄
    local base_path="/Users/chying/Documents/AIAgent"
    
    # 使用穩健的 if/else 語法來處理大小寫不同的特殊情況
    local dir_account_name
    if [ "$account_name" = "alfiegbc" ]; then
        dir_account_name="AlfieGBC"
    else
        dir_account_name="$account_name"
    fi

    local proj_path="$base_path/$dir_account_name/$project_name"

    # 檢查帳號是否為支援的帳號，並設定 SSH 別名
    case "$account_name" in
        febedev|alfiegbc|b1uewave|chying1219)
            local ssh_alias="$account_name"
            ;;
        *)
            echo "錯誤: 不支援的帳號 '$1'。"
            return 1
            ;;
    esac

    echo "在 $proj_path 建立新專案..."
    mkdir -p "$proj_path"
    cd "$proj_path" || return

    git init
    echo "✅ Git 已初始化，自動設定的使用者為："
    git whoami
    echo "" # 換行

    echo "# $project_name" > README.md
    git add .
    git commit -m "Initial commit"

    echo "✅ 專案 '$project_name' 已建立。"
    echo "下一步："
    echo "1. 請在 GitHub ($account_name 帳號) 上建立一個新的 repository '$project_name'。"
    echo "2. 執行以下指令來連結遠端倉庫 (請自行替換 <org_or_user>):"
    echo "   git remote add origin git@$ssh_alias:<org_or_user>/$project_name.git"
    echo "   git push -u origin main"

    # 用 VS Code 開啟新專案
    code .
}


# ==============================================================================
#           ✨ 終極版 gclone 與輔助函式 ✨
# ==============================================================================

#
# gclone()
# 功能: 終極智慧型 git clone。自動建立帳號目錄、切換身份並 clone 專案。
#
gclone() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "使用方式: gclone <ssh_alias> <github_user/repo_name>"
        echo "可用的別名請執行: git-aliases"
        return 1
    fi

    local ssh_alias=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local repo_path="$2"
    local base_path="/Users/chying/Documents/AIAgent"

    # 處理 AlfieGBC 目錄大小寫不同的特殊情況
    local dir_account_name
    if [ "$ssh_alias" = "alfiegbc" ]; then
        dir_account_name="AlfieGBC"
    else
        dir_account_name="$ssh_alias"
    fi
    
    local account_dir="$base_path/$dir_account_name"
    local repo_name=$(basename "$repo_path")
    local final_proj_path="$account_dir/$repo_name"

    # 1. 檢查目標路徑是否已存在
    if [ -d "$final_proj_path" ]; then
        echo "❌ 錯誤: 目的地路徑 '$final_proj_path' 已經存在。"
        echo "請先手動刪除或移開它，再重新執行。"
        return 1
    fi

    # 2. 檢查並建立帳號目錄
    if [ ! -d "$account_dir" ]; then
        echo "ℹ️ 帳號目錄 '$dir_account_name' 不存在，正在為您建立..."
        mkdir -p "$account_dir"
    fi

    # 3. 進入該目錄
    cd "$account_dir" || return
    echo "✅ 已進入帳號目錄: $PWD"
    
    # 4. 執行 clone，如果失敗則中止
    echo "🚀 準備 clone '$repo_path'..."
    git clone "git@$ssh_alias:$repo_path.git" || return 1

    # 5. 進入剛 clone 下來的專案並做身份檢查
    if [ -d "$repo_name" ]; then
        cd "$repo_name"
        echo "✅ Clone 完成，已進入專案目錄: $PWD"
        echo -n "身份檢查... Git 使用者為: "
        git whoami # 身份檢查現在移到這裡，確保在 git repo 內執行
    else
        echo "❌ Clone 失敗，請檢查上面的錯誤訊息和您的權限。"
        return 1
    fi
}

#
# git-aliases()
# 功能: 列出所有可用的 GitHub SSH 別名。
#
git-aliases() {
    echo "可用的 GitHub SSH 別名："
    grep "^Host " "/Users/chying/Documents/AIAgent/setup-github/ssh_config" | grep -v "vagrant" | awk '{print "  - " $2}'
}
