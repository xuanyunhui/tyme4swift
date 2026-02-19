# Agent Teams：团队结构与工作流

本文档描述本仓库中 **Agent Teams** 的团队结构、各 agent 职责、在 DevSecOps 流水线中的阶段，以及典型触发方式。CLAUDE.md 中有简要摘要。

## 团队结构

| 角色 | 职责 | Agent 文件 | 所在阶段 |
|------|------|------------|----------|
| **开发 (Dev)** | 实现功能、按门禁反馈修复、遵循 CLAUDE.md 与项目约定 | `.claude/agents/ios-dev.md` | ① 开发 |
| **QA** | 设计测试策略与用例、执行测试（如 `swift test`）、输出测试报告与 Sign-off | `.claude/agents/qa.md` | ② 构建与测试 |
| **架构师 (Architect)** | PR 架构评审（模块边界、模式一致性、依赖分层、CLAUDE 约定），输出 APPROVE / REQUEST_CHANGES | `.claude/agents/architect.md` | ③ 提交与评审（一轨） |
| **Audit Manager** | 全量审计；调度 code-reviewer、silent-failure-hunter、pr-test-analyzer、code-simplifier 等；输出审计报告与 Sign-off/Reject | `.claude/agents/audit-manager.md` | ③ 提交与评审（另一轨） |
| **Team Lead** | 合并 PR、更新 Issue checklist、通知进入下一 Phase | 人工 | ④ 发布 |

**子工具（由 Audit Manager 在 `/audit` 等命令下调度）**：code-reviewer、silent-failure-hunter、pr-test-analyzer、code-simplifier、type-design-analyzer 等；不单独作为顶层 agent 列出。

## 工作流模式（按阶段）

- **① 开发**  
  - **谁**：ios-dev（开发 agent）。  
  - **做什么**：实现需求或根据门禁反馈修复。  
  - **门禁**：无；输出进入 ②。

- **② 构建与测试**  
  - **谁**：构建（`swift build` + 自动化测试）+ QA agent（设计/执行测试、`swift test`、报告与 Sign-off）。  
  - **门禁**：QA 测试通过才可提交 PR；不通过则反馈回 ① 开发，修复后从 ② 重跑。

- **③ 提交与评审**  
  - **谁**：开发者推送分支、创建 PR 后，**并行**两轨：  
    - **架构师**：架构评审 → GitHub Review（APPROVE / REQUEST_CHANGES）。  
    - **Audit Manager**：全量审计 → 向 team-lead 汇报 Sign-off / Reject。  
  - **门禁**：两轨均通过才可合并；任一方 REQUEST_CHANGES / Reject 则反馈回 ① 开发，修复后从 ② 重跑全管道。

- **④ 发布**  
  - **谁**：Team Lead（人）。  
  - **做什么**：rebase 合并 PR、更新 Issue checklist、通知进入下一 Phase。

详细流程图（Mermaid）见 [swift-developer-flow.md](swift-developer-flow.md)。


## 与 Audit 命令的对应

| 命令 | 说明 | 主要涉及 Agent/工具 |
|------|------|----------------------|
| `/audit <pr_id>` | 全量审计（含 Code Health） | Audit Manager，调度 code-reviewer、silent-failure-hunter、type-design-analyzer、pr-test-analyzer、code-simplifier 等 |
| `/audit-quick <pr_id>` | 快速检查 | Audit Manager，仅 code-reviewer + pr-test-analyzer |
| `/audit-fix <issue_id>` | 针对问题生成修复 | code-simplifier |
| `/simplify <file_path>` | 单文件简化建议 | code-simplifier |
| `/refactor-pr <pr_id>` | PR 内简化扫描与 Commit 建议 | code-simplifier |

架构师评审与 Audit Manager 审计相互独立，两者均在 ③ 阶段执行，共同构成「质量与合规门禁」。
