# 贡献指南

感谢你对 tyme4swift 的关注！我们欢迎各种形式的贡献。

## 提交前准备

### 代码质量检查

项目使用 SwiftLint 保持代码风格一致。提交 Pull Request 前，建议在本地运行 SwiftLint 检查：

```bash
# 安装 SwiftLint（如果尚未安装）
brew install swiftlint

# 检查代码
swiftlint lint --path Sources
```

### 运行测试

提交前请确保所有测试通过：

```bash
swift test
```

## 提交 Pull Request

1. Fork 本仓库
2. 创建你的特性分支（`git checkout -b feature/amazing-feature`）
3. 提交你的更改（`git commit -m 'Add some amazing feature'`）
4. 推送到分支（`git push origin feature/amazing-feature`）
5. 开启一个 Pull Request

## Pull Request 规范

- **标题**：简洁描述改动内容
- **描述**：详细说明改动原因和实现方式
- **测试**：包含必要的测试用例
- **对齐**：如果涉及算法改动，确保与 [tyme4j](https://github.com/6tail/tyme4j) 保持一致

## 分支策略

- **main**：主分支，保持稳定
- **feature/**：新功能分支
- **fix/**：Bug 修复分支

## PR 合并方式

本仓库只允许 **rebase** 合并方式，不允许 merge commit 和 squash。

## 代码规范

- 遵循 Swift 官方代码风格
- 使用有意义的变量和函数名
- 添加必要的注释（特别是复杂算法）
- 保持与 tyme4j 的算法一致性

## 联系方式

有任何问题或建议，欢迎：
- 提交 [GitHub Issue](https://github.com/xuanyunhui/tyme4swift/issues)
- 在 Pull Request 中讨论

再次感谢你的贡献！🎉
