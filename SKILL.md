---
name: legal-judgment-predictor
description: >
  中国法裁判预测框架。输入案件事实，输出法条预测、胜败方向、量刑/金额区间、
  置信度及推理链。基于三角色对抗辩论（原告/被告→法官综合裁决）。
  引用 laubeing-droid/Claude-for-Legal-CN-to-Codex 知识库进行法律知识注入。
argument-hint: '[案件事实描述 | 案由 + 关键事实]'
---

# 裁判预测框架

## 工作流

```
案件事实输入
    ↓
1. 事实要素结构化抽取（动机→行为→后果→争议焦点）
    ↓
2. 原告/公诉方视角论证（主张 + 法条依据 + 证据支撑点）
    ↓
3. 被告/辩护方视角反驳（抗辩理由 + 法条依据 + 证据弱点）
    ↓
4. 法官综合裁决（采信判断 + 法条适用 + 结果推导）
    ↓
5. 多维度自评（一致性/法条准确/逻辑完整/类案偏离度）
    ↓
输出：法条预测 + 结果预测 + 置信度 + 推理链 + 自评报告
```

## 执行指令

1. 加载 `extract/fact-elements.md`，对输入的案件事实进行结构化抽取
2. 加载 `prompts/plaintiff.md`，以原告/公诉方立场构建论证
3. 加载 `prompts/defendant.md`，以被告/辩护方立场构建反驳
4. 加载 `debate/rounds.md`，按 3 轮编排对抗辩论
5. 加载 `predict/` 对应案由模板，生成判决预测
6. 加载 `evaluate/metrics.md`，完成多维度自评
7. 加载 `report/template.md`，输出结构化预测报告

## 法律知识注入

- 引用 `Claude-for-Legal-CN` 知识库：`law-semantic-tree.json` 法条要件 + `blocking-list.md` 阻断概念
- 引用 `reasoning-template-zh.md` 中国法推理链
- 禁止使用 IRAC 结构，强制使用请求权基础分析法（民事）/犯罪构成四要件或三阶层（刑事）/行政行为合法性审查（行政）

## 重要限制

- 所有预测结果均为 AI 辅助分析，不构成法律意见
- 置信度标注须基于推理链完整性，非主观判断
- 最终决策须经执业律师审核