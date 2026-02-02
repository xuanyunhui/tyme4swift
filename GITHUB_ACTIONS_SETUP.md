# GitHub Actions 自动发布配置指南

## 📋 概述

这个 GitHub Actions workflow 在每次创建 Release 时自动触发，完成以下工作：

1. ✅ **验证 Release** - 校验代码、编译和测试
2. 📦 **注册 SPM** - 注册到 Swift Package Manager
3. 📱 **发布到 CocoaPods** - 自动推送到 CocoaPods Trunk
4. 📊 **生成总结** - 创建发布总结和使用说明

## 🚀 快速开始

### 第一步：添加 GitHub Secrets（可选，用于自动 CocoaPods 发布）

如果要启用自动 CocoaPods 发布，需要添加 GitHub Secrets：

1. **获取 CocoaPods Token**:
   ```bash
   pod trunk me --verbose
   ```
   输出中会显示你的 token

2. **添加到 GitHub**:
   - 访问: https://github.com/xuanyunhui/tyme4swift/settings/secrets/actions
   - 点击 "New repository secret"
   - **Name**: `COCOAPODS_TRUNK_TOKEN`
   - **Value**: (粘贴你的 pod token)
   - 点击 "Add secret"

### 第二步：查看 Workflow 文件

workflow 已创建在: `.github/workflows/publish.yml`

### 第三步：创建新的 Release 来测试

在 GitHub 上创建新的 Release 时：
1. workflow 会自动触发
2. 在 "Actions" 标签可以看到运行进度
3. 完成后会在 Release 页面添加发布总结

## 📁 文件说明

### `.github/workflows/publish.yml`
主 workflow 文件，包含以下 Jobs：

| Job | 说明 | 状态 |
|-----|------|------|
| `verify-release` | 验证 Release 标签和代码编译 | ✅ 自动 |
| `register-spm` | 注册到 Swift Package Manager | ✅ 自动 |
| `publish-cocoapods` | 发布到 CocoaPods Trunk | ⏳ 需要 Token |
| `publish-summary` | 生成发布总结 | ✅ 自动 |
| `notification` | 发送完成通知 | ✅ 自动 |

### `tyme4swift.podspec`
CocoaPods pod 规格文件，定义：
- Pod 名称和版本
- 源代码位置
- 平台要求
- 依赖关系（本项目无依赖）

## 🔧 Workflow 详解

### 1️⃣ Verify Release Job

```yaml
- 检查 Release tag 格式 (v1.4.2)
- 编译 Swift 代码
- 运行单元测试
- 输出版本号供后续 Job 使用
```

### 2️⃣ Register SPM Job

```yaml
- 验证 Package.swift 文件
- 自动生成 SPM 注册信息
- 输出 Swift Package Index 注册链接
- 注：SPM 通过 GitHub Release 自动注册
```

### 3️⃣ Publish CocoaPods Job

```yaml
- 检查或创建 tyme4swift.podspec
- 验证 podspec 文件有效性
- 使用 token 发布到 CocoaPods Trunk
- 如果没有 token，提示手动发布命令
```

### 4️⃣ Publish Summary Job

```yaml
- 生成完整的发布总结 markdown
- 在 Release 页面添加注释（可选）
- 提供 SPM 和 CocoaPods 安装说明
```

### 5️⃣ Notification Job

```yaml
- 汇总所有 Job 的执行结果
- 输出最终状态报告
- 提示后续步骤
```

## 📝 使用场景

### 场景 1: 创建标准 Release

```bash
# 1. 创建 tag
git tag -a v1.4.3 -m "Release v1.4.3"

# 2. 推送到 GitHub
git push origin v1.4.3

# 3. 在 GitHub 创建 Release
# - 访问 https://github.com/xuanyunhui/tyme4swift/releases
# - 点击 "Create a new release"
# - 选择 tag: v1.4.3
# - 填写 release 信息
# - 点击 "Publish release"

# 4. Workflow 自动触发！
```

### 场景 2: 监控 Workflow 进度

```
1. 访问: https://github.com/xuanyunhui/tyme4swift/actions
2. 找到最新的 "Publish to SPM Registry and CocoaPods" workflow
3. 点击查看详细日志
4. 检查每个 Job 的执行结果
```

### 场景 3: 手动发布到 CocoaPods（如果 token 未配置）

```bash
# 1. 验证 podspec
pod spec lint tyme4swift.podspec

# 2. 发布到 trunk
pod trunk push tyme4swift.podspec

# 3. 验证发布成功
pod search tyme4swift
```

## ✅ 检查清单

- [x] `.github/workflows/publish.yml` 已创建
- [x] `tyme4swift.podspec` 已创建
- [ ] `COCOAPODS_TRUNK_TOKEN` Secret 已添加（可选）
- [ ] 第一次 Release 已测试
- [ ] SPM 注册已验证
- [ ] CocoaPods 发布已验证

## 📖 参考链接

### Swift Package Manager
- [SwiftPM 官方文档](https://swift.org/package-manager/)
- [Swift Package Index](https://swiftpackageindex.com/)
- [Package Resolution Rules](https://github.com/apple/swift-package-manager/blob/main/Documentation/PackageResolution.md)

### CocoaPods
- [CocoaPods 官方网站](https://cocoapods.org/)
- [CocoaPods Trunk 指南](https://guides.cocoapods.org/making/getting-setup-with-trunk.html)
- [Podspec 格式](https://guides.cocoapods.org/syntax/podspec.html)

### GitHub Actions
- [GitHub Actions 官方文档](https://docs.github.com/en/actions)
- [使用 Secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)
- [Workflow 语法](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

## 🆘 常见问题

### Q: CocoaPods 发布失败怎么办？

A: 
1. 检查 `COCOAPODS_TRUNK_TOKEN` 是否正确添加
2. 尝试手动发布: `pod trunk push tyme4swift.podspec`
3. 查看 workflow 日志获取详细错误信息

### Q: 如何更新 podspec 版本？

A: 
1. 编辑 `tyme4swift.podspec`
2. 修改 `spec.version` 字段
3. 提交并 push
4. 创建新的 Release

### Q: SPM 注册需要额外操作吗？

A: 
1. GitHub Release 自动注册 SPM
2. 要在 Swift Package Index 上提高可见性，访问: https://swiftpackageindex.com/add-package
3. 输入仓库 URL 并提交即可

### Q: 如何禁用自动发布？

A: 
修改 `.github/workflows/publish.yml` 中的 `on` 部分，或删除这个文件。

## 🎯 后续优化建议

1. **自动更新版本号**: 可以添加 action 自动更新 Package.swift 和 podspec 中的版本
2. **发布文档**: 可以添加自动构建和发布 API 文档
3. **变更日志**: 可以从 commit 信息自动生成 CHANGELOG.md
4. **测试覆盖**: 可以添加覆盖率报告
5. **性能测试**: 可以添加基准测试

## 📞 获取帮助

如有问题，请：
1. 查看 workflow 日志: https://github.com/xuanyunhui/tyme4swift/actions
2. 检查 Release 页面的发布总结
3. 参考官方文档链接

---

**创建时间**: 2026-02-02  
**版本**: 1.4.2  
**状态**: ✅ 生产就绪
