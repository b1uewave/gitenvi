# gitenvi - Git 多帳號環境管理器

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Homebrew Version](https://img.shields.io/badge/homebrew-v0.1.0-orange.svg)](https://github.com/b1uewave/homebrew-gitenvi)

無縫管理多個 Git 身份，告別繁瑣的設定切換。`gitenvi` 讓您能根據專案目錄，自動使用正確的 Git 使用者和 SSH 金鑰。

---

## 解決的問題

您是否也曾遇到以下困擾？
- 在公司專案中，不小心用了個人的 GitHub 帳號 commit。
- 維護開源專案時，需要手動切換 SSH 金鑰才能 push。
- 每次開始一個新專案，都要重複設定 `user.name` 和 `user.email`。

`gitenvi` 將這一切變為過去式，讓您專注於真正重要的事——寫程式。

## ✨ 主要特性

* **全自動身份切換**: 根據您所在的目錄結構，自動應用對應的 Git 使用者設定。
* **智慧金鑰管理**: 透過 SSH 別名，自動為不同的 GitHub 帳號選用正確的 SSH 金鑰。
* **零摩擦專案啟動**: 提供 `gitenvi new` 指令，一鍵完成新專案的目錄建立、Git 初始化和身份設定。
* **智慧型 `clone`**: 提供 `gitenvi clone` 指令，能自動建立帳號目錄並使用正確的別名 clone 專案。
* **高度可配置**: 只需一個 `config.json` 檔案，即可輕鬆管理您所有的帳號資訊。

## 🚀 安裝

透過 Homebrew，您可以輕鬆安裝 `gitenvi`：

```bash
# 1. 添加 b1uewave 的 Tap (只需執行一次)
brew tap b1uewave/gitenvi

# 2. 安裝 gitenvi
brew install gitenvi
```

## 快速上手

#### 1. 首次設定

安裝完成後，執行 `setup` 指令來初始化您的個人設定。

```bash
gitenvi setup
```
這會在 `~/.config/gitenvi/` 目錄下為您建立一份 `config.json` 設定檔。請根據提示用編輯器打開它，並填入您自己的帳號資訊。

**`config.json` 範例：**
```json
{
  "project_base_path": "~/dev",
  "accounts": [
    {
      "alias": "personal",
      "github_user": "b1uewave",
      "git_name": "Blue",
      "git_email": "b1uewave@gmail.com",
      "ssh_key_path": "~/.ssh/b1uewave_rsa"
    },
    {
      "alias": "work",
      "github_user": "ye11owwave",
      "git_name": "Yang",
      "git_email": "ye11owwave@gmail.com",
      "ssh_key_path": "~/.ssh/ye11owwave_rsa"
    }
  ]
}
```
> **注意**: `install.sh` / `gitenvi setup` 的完整功能將在後續版本中實現。目前請手動建立並連結設定檔。

#### 2. 使用指令

設定完成後，您就可以開始享受自動化的便利了！

* **列出所有帳號別名:**
  ```bash
  gitenvi aliases
  ```

* **建立一個新專案:**
  ```bash
  # gitenvi new <帳號別名> <專案名稱>
  gitenvi new personal my-awesome-project
  ```

* **Clone 一個已存在的專案:**
  ```bash
  # gitenvi clone <帳號別名> <GitHub用戶名/倉庫名>
  gitenvi clone work ye11owwave/internal-dashboard
  ```

## 授權

本專案採用 [MIT License](LICENSE)。
Copyright (c) 2025 b1uewave