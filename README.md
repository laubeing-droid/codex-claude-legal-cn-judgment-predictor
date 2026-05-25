<!--
version: 1.0.2
module: judgment-predictor
status: active
-->

# Codex-Legal-CN-Judgment-Predictor 🏛️

> **中国法裁判预测框架** — 输入案件事实，输出结构化判决预测报告

纯 Prompt 驱动，零模型训练。基于三角色对抗辩论（原告 / 被告 → 法官综合裁决），深度联动自有仓库知识库和 MCP 工具，为法律从业者提供可溯源、可评估的判决预测能力。

---

## 项目简介

**Codex-Legal-CN-Judgment-Predictor** 是一个面向中国法律实务场景的智能判决预测工具。它不走传统 ML 训练路线，而是以**大语言模型 Prompt 编排**为核心，通过模拟真实庭审中原告主张、被告抗辩、法官裁决的对抗过程，生成结构化的判决预测报告。

核心设计理念：

- **对抗求真**：让 AI 分别扮演原告方、被告方、法官三个角色，通过多轮辩论碰撞出更接近真实裁判的预测结果
- **纯 Prompt 驱动**：所有逻辑通过提示词模板编排，零模型训练/微调，易于维护和迭代
- **深度联动**：对接 [codex-claude-legal-cn-core-codices](https://github.com/laubeing-droid/codex-claude-legal-cn-core-codices)（162部法条要件、阻断概念、推理链）和 MCP 工具（类案检索、法条核验），确保预测有据可依
- **结构化输出**：从案件要素抽取到判决预测再到自评报告，全链路标准化

---

## 快速开始

```
@legal-judgment-predictor [案件事实描述]
```

详见 [QUICKSTART.md](docs/QUICKSTART.md)

---

## 工作流

```
案件事实 → 要素抽取 → 原告论证 → 被告抗辩 → 法官裁决 → 自评 → 报告
```

七步流水线，每一步都有独立的 Prompt 模板和评估标准：

| 阶段 | 模块 | 说明 |
|:---|---:|:---|
| 1. 要素抽取 | `extract/fact-elements.md` | 从案件事实中结构化抽取当事人、案由、争议焦点、证据链等关键要素 |
| 2. 原告论证 | `prompts/plaintiff.md` | 模拟原告/公诉方立场，构建最优诉讼主张与法条支持 |
| 3. 被告抗辩 | `prompts/defendant.md` | 模拟被告/辩护方立场，提出抗辩理由与阻断概念 |
| 4. 法官裁决 | `prompts/judge.md` | 综合双方意见，基于法律要件做出中立裁决判断 |
| 5. 对抗辩论 | `debate/rounds.md` | 3 轮对抗辩论编排，逐步逼近事实真相与法律适用 |
| 6. 判决预测 | `predict/{civil,criminal,admin}.md` | 按民事/刑事/行政三大领域输出具体判决预测 |
| 7. 自评报告 | `evaluate/metrics.md` → `report/template.md` | 5 维度自评 + 结构化预测报告生成 |

详见 [ARCHITECTURE.md](docs/ARCHITECTURE.md)

---

## 目录结构

```
├── SKILL.md                          # Codex 技能入口
├── README.md
├── LICENSE                           # MIT
├── CHANGELOG.md
├── REFERENCES.md                     # 引用来源与联动说明
├── .gitignore
├── .github/workflows/
│   └── upstream-monitor.yml          # 5 个参考项目每周监控
├── docs/
│   ├── ARCHITECTURE.md               # 架构设计
│   └── QUICKSTART.md                 # 快速开始
├── prompts/
│   ├── plaintiff.md                  # 原告/公诉方视角
│   ├── defendant.md                  # 被告/辩护方视角
│   └── judge.md                      # 法官综合裁决
├── extract/
│   └── fact-elements.md              # 事实要素结构化抽取
├── debate/
│   └── rounds.md                     # 3 轮对抗辩论编排
├── predict/
│   ├── civil.md                      # 民事判决预测
│   ├── criminal.md                   # 刑事判决预测
│   └── admin.md                      # 行政判决预测
├── evaluate/
│   └── metrics.md                    # 5 维度自评
├── report/
│   └── template.md                   # 结构化预测报告模板
└── mcp/
    └── linkage.md                    # MCP Hub 联动策略
```

---

## 联动仓库

本项目深度依赖以下自有知识库和工具链：

| 仓库 | 联动方式 | 用途 |
|:---|:---|:---|
| [laubeing-droid/Claude-for-Legal-CN-to-Codex](https://github.com/laubeing-droid/Claude-for-Legal-CN-to-Codex) | 文件读取 | 法条要件 + 阻断概念 + 推理链 |
| [laubeing-droid/Codex-Claude-legal-cn-mcp-hub](https://github.com/laubeing-droid/Codex-Claude-legal-cn-mcp-hub) | MCP 协议 | 类案检索 + 法条核验 |

---

## 外部参考（断开但监控）

以下项目启发了本框架的设计思路，通过 GitHub Actions 每周监控其更新：

| 项目 | 引用要点 |
|:---|:---|
| ZhouZiai/Multi-agent-system-for-legal-judgment_ | 三角色对抗辩论思路 |
| zhang17173/Event-Extraction | 法律事件要素抽取方法论 |
| jiangxia/ai-trial | 法律角色扮演与庭审流程 |
| shwann/LexSim | 判决预测报告结构与评估指标 |
| nexorin9/medical-trial-simulator | 模块化四层分离架构 |

详见 [REFERENCES.md](REFERENCES.md)

---

## 适用场景

- **律师 / 法务**：接案评估、诉讼策略模拟、和解谈判参考
- **当事人**：快速了解案件的合理预期，降低信息不对称
- **法学研究**：裁判规律挖掘、司法一致性分析、量刑偏差研究
- **法律科技产品**：作为智能法律服务产品的判决预测引擎

---

## 版本历史

| 版本 | 日期 | 要点 |
|:---|:---|---|
| v1.0.2 | 2026-05-25 | 完善 README 文档，补充项目简介与适用场景 |
| v1.0.1 | 2026-05-25 | 修复文档链接与 MCP 联动说明 |
| v1.0.0 | 2026-05-25 | 初始发布：三角色 Prompt、要素抽取、3 轮辩论、民事/刑事/行政预测、自评报告 |

详见 [CHANGELOG.md](CHANGELOG.md)

---

## 许可证

MIT

---

## 免责声明

本项目仅供法律研究与参考，不构成正式法律意见。具体案件请咨询执业律师。
