---
name: legal-judgment-predictor
description: >
  中国法裁判预测框架。输入案件事实，输出结构化判决预测报告（法条 + 胜败方向 +
  金额/刑期区间 + 置信度 + 推理链 + 自评）。基于三角色对抗辩论（原告/被告 → 法官综合裁决）。
  支持民事/刑事/行政三类案由。
argument-hint: '[案由] [案件事实描述]'
version: 1.0.1
platforms: [codex, claude-code, workbuddy, trae]
module: judgment-predictor
status: active
---

# 裁判预测框架

## 概述

中国法 AI 裁判预测框架，纯 Prompt 驱动，零模型训练。
深度联动 [laubeing-droid/Claude-for-Legal-CN-to-Codex](https://github.com/laubeing-droid/Claude-for-Legal-CN-to-Codex) 知识库
和 [laubeing-droid/Codex-Claude-legal-cn-mcp-hub](https://github.com/laubeing-droid/Codex-Claude-legal-cn-mcp-hub) MCP 工具。

## 工作流

```
案件事实 → 要素抽取 → 原告论证 → 被告抗辩 → 法官裁决 → 自评 → 报告
```

## 执行指令

### 第 0 步：环境检测
- 检测 `~/.codex/skills/references/law-semantic-tree.json` 是否存在（知识库）
- 检测 MCP 工具 `chineselaw` 是否可用（类案检索）
- 缺失项在报告中标注，但不阻止执行

### 第 1 步：事实要素抽取
加载 `extract/fact-elements.md`，对输入的案件事实结构化抽取：
- 主体识别 → 行为事实 → 结果事实 → 争议焦点 → 案由判定

### 第 2 步：知识注入
- 读取 `~/.codex/skills/references/law-semantic-tree.json`（法条→要件→效果）
- 读取 `~/.codex/skills/references/law-versions.json`（法条版本追踪）
- 读取 `~/.codex/patches/guards/blocking-list.md`（29 项阻断概念）
- 确认案由对应的 `reasoning-template-zh.md` 推理链

### 第 3 步：原告方论证
加载 `prompts/plaintiff.md`，以原告/公诉方立场构建论证：
- 事实主张 + 法条依据 + 证据支撑点 + 诉讼请求/量刑建议

### 第 4 步：被告方抗辩
加载 `prompts/defendant.md`，以被告/辩护方立场构建反驳：
- 事实抗辩 + 法律抗辩 + 证据质疑 + 反诉评估

### 第 5 步：对抗辩论
加载 `debate/rounds.md`，按 3 轮编排：
- 第 1 轮：事实主张与抗辩 → 法官归纳争议事实
- 第 2 轮：法律适用辩论 → 法官归纳法律争议
- 第 3 轮：综合辩论与最后陈述 → 法官闭庭

### 第 6 步：MCP 联动（如可用）
按 `mcp/linkage.md` 调用 MCP 工具：
- 案例库：类案检索（事实抽取后 + 双方各搜一次 + 自评偏离度）
- 国家法规库：法条现行有效性核验
- 元典智库：裁判规则综合检索

### 第 7 步：法官裁决
加载 `prompts/judge.md`，综合双方论证：
- 事实认定 + 法律适用 + 裁判推理 + 结果预测 + 关键因子分析

### 第 8 步：判决预测
根据案由加载对应模板：
- 民事 → `predict/civil.md`：请求权基础分析 + 胜败方向 + 金额预测
- 刑事 → `predict/criminal.md`：犯罪构成检视 + 定罪可能性 + 量刑预测
- 行政 → `predict/admin.md`：合法性审查 + 判决方向预测

### 第 9 步：多维度自评
加载 `evaluate/metrics.md`：
- 法条准确性 / 逻辑完整性 / 阻断概念过滤 / 结果一致性 / 推理深度
- 全部 ✅ 才结束，有 ❌ 须修正后重新自评

### 第 10 步：输出报告
加载 `report/template.md`，输出结构化预测报告。

## 推理规则

- **禁止 IRAC**：民事使用请求权基础分析法，刑事使用犯罪构成要件检视，行政使用合法性审查
- **禁止美国法概念**：输出前扫描 29 项阻断清单（blocking-list.md），命中即替换
- **禁止境外法域引用**：不引用美国/英国/香港等法域法律

## 重要限制

- 所有预测结果均为 AI 辅助分析，不构成法律意见
- 置信度基于推理链完整性，非结果保证
- 法条引用须标注版本和核验状态
- 最终决策须经执业律师审核
