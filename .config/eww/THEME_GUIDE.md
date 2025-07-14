# EWW主题系统使用指南

## 🎨 概述

EWW配置现在支持完整的主题系统，可以轻松切换不同的视觉风格。

## 📁 主题文件结构

```
themes/
├── gruvbox-dark.scss          # Gruvbox暗色主题
├── catppuccin-mocha.scss      # Catppuccin Mocha主题
├── gruvbox-dark.yuck          # 主题变量（文档用）
├── catppuccin-mocha.yuck      # 主题变量（文档用）
└── current.scss -> gruvbox-dark.scss  # 当前主题符号链接
```

## 🎯 可用主题

### Gruvbox Dark
- **特色**: 温暖的复古配色，护眼舒适
- **颜色**: 棕色背景，橙色高亮，适合长时间使用
- **风格**: 复古、温暖、舒适

### Catppuccin Mocha  
- **特色**: 现代的柔和配色，优雅简洁
- **颜色**: 深蓝背景，粉色高亮，现代感强
- **风格**: 现代、柔和、优雅

## 🚀 使用方法

### 查看当前主题
```bash
./switch_theme.sh
```

### 切换主题
```bash
# 切换到Gruvbox Dark
./switch_theme.sh gruvbox-dark

# 切换到Catppuccin Mocha
./switch_theme.sh catppuccin-mocha
```

### 启动时指定主题
```bash
# 启动Hyprland bar并应用指定主题
./launch_hyprland.sh --theme catppuccin-mocha

# 启动Scroll bar并应用指定主题
./launch_scroll.sh --theme gruvbox-dark
```

## 🔧 创建新主题

### 步骤1: 创建CSS文件
```bash
cp themes/gruvbox-dark.scss themes/my-theme.scss
```

### 步骤2: 自定义颜色
编辑 `themes/my-theme.scss`，修改以下关键颜色变量：
- `background` - 主背景色
- `color` - 主文字色  
- `border-color` - 边框色
- `.workspace.focused` - 焦点工作区颜色
- `.wifi-item`, `.volume-item`, `.time-item` - 状态栏项目颜色

### 步骤3: 应用主题
```bash
./switch_theme.sh my-theme
```

## 🎨 主题设计原则

### 颜色搭配
- **背景色**: 深色为主，减少眼疲劳
- **文字色**: 与背景形成足够对比度
- **高亮色**: 用于焦点和交互元素
- **边框色**: 比背景稍亮，用于分割

### 视觉层次
- **工作区**: 清晰的焦点/非焦点状态
- **状态栏**: 每个组件有独特但协调的颜色
- **交互**: 悬停状态提供视觉反馈

## 🔄 主题系统技术实现

### 多CSS文件方案
- 每个主题是独立的CSS文件
- 通过符号链接管理当前主题
- 切换时复制主题文件到主CSS文件
- 自动重新加载eww应用更改

### 优势
- ✅ **即时生效**: 切换后立即应用
- ✅ **完全控制**: 每个主题可完全自定义
- ✅ **易于扩展**: 添加新主题只需创建CSS文件
- ✅ **稳定可靠**: 不依赖复杂的变量系统

## 🛠️ 故障排除

### 主题未生效
```bash
# 检查当前主题
./switch_theme.sh

# 手动重新加载
eww reload
```

### 创建主题时的注意事项
- 确保CSS语法正确
- 保持类名与原始主题一致
- 测试所有widget的显示效果
- 考虑不同状态的颜色搭配

## 📝 扩展建议

### 主题变体
- 创建同一主题的亮色/暗色版本
- 针对不同时间段的主题（日间/夜间）
- 季节性主题变化

### 自动化
- 根据时间自动切换主题
- 根据壁纸颜色自动生成主题
- 与系统主题同步

现在你的EWW配置拥有了完整而灵活的主题系统！🎉
