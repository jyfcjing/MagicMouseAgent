# MagicMouseAgent 中文说明

这个项目是一个很小的 macOS 工具，目标很简单：
替代一小部分 BetterTouchTool 的 Magic Mouse 手势。

如果你不是技术人员，直接看下面这部分就够了。

## 最简单的用法

如果仓库里已经有打好的发布包：

1. 从 GitHub Releases 下载最新的 `MagicMouseAgent-xxx-macos.zip`
2. 解压到任意目录
3. 双击 `Start MagicMouseAgent.command`
4. 第一次运行时，到

```text
系统设置 -> 隐私与安全性 -> 辅助功能
```

把下面这个 app 打开权限：

```text
build/MagicMouseAgent.app
```

5. 去 Chrome 里测试手势
6. 如果想开机自动启动，双击 `Install at Login.command`

如果你下载的是源码，而不是打包好的 zip：

1. 先安装 Xcode Command Line Tools
2. 双击 `Build and Start MagicMouseAgent.command`
3. 按提示给辅助功能权限

## 现在默认支持的动作

- 全局：单指轻点 = 左键
- 全局：右前方轻点 = 右键
- Chrome：单指左滑 = 切到左边标签页
- Chrome：单指右滑 = 切到右边标签页
- Chrome：双指轻点 = 关闭当前标签页
- Chrome：右边按住，左边轻点 = 恢复刚关闭的标签页
- Chrome：左边按住，右边轻点 = 新建标签页

## 这些文件是给普通用户准备的

你可以直接双击：

- `Build and Start MagicMouseAgent.command`
- `Start MagicMouseAgent.command`
- `Stop MagicMouseAgent.command`
- `Install at Login.command`
- `Uninstall from Login.command`

## 出问题时先这样试

1. 彻底退出 Chrome，再重新打开
2. 在辅助功能里把 `build/MagicMouseAgent.app` 删掉后重新添加
3. 先双击 `Stop MagicMouseAgent.command`，再双击 `Start MagicMouseAgent.command`
4. 如果 macOS 提示“无法打开”或“未验证开发者”，对脚本或 app 右键，选一次“打开”

## 给技术用户的命令

构建：

```bash
python3 ./generate_config.py
./build.sh
```

打包：

```bash
./package.sh
```

常用命令：

```bash
./start.sh
./stop.sh
./status.sh
./install-login-agent.sh
./uninstall-login-agent.sh
```

查看日志：

```bash
/usr/bin/log show --style compact --last 8m --predicate 'process == "MagicMouseAgent"'
```

## 说明

- 这个项目和 Jitouch 一样，使用了 Apple 的私有 `MultitouchSupport` 框架
- 现在默认是 ad-hoc 签名，不是 notarized 正式分发包
- 如果后面要做给更多普通用户的一键安装版，下一步应该是做 GitHub Release、Developer ID 签名和 notarization
