# Codex-Legal-CN-Judgment-Predictor

> 中国法裁判预测框架 — 输入案件事实，输出结构化判决预测报告

纯 Prompt 驱动，零模型训练。基于三角色对抗辩论（原告/被告→法官综合裁决）。
深度联动自有仓库知识库和 MCP 工具。

## 快速开始

```
@legal-judgment-predictor [案件事实描述]
```

详见 [QUICKSTART.md](docs/QUICKSTART.md)

## 工作流

```
案件事实 → 要素抽取 → 原告论证 → 被告抗辩 → 法官裁决 → 自评 → 报告
```

详见 [ARCHITECTURE.md](docs/ARCHITECTURE.md)

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

## 联动仓库

| 仓库 | 联动方式 | 用途 |
|:-----|:---------|:-----|
| [laubeing-droid/Claude-for-Legal-CN-to-Codex](https://github.com/laubeing-droid/Claude-for-Legal-CN-to-Codex) | 文件读取 | 法条要件 + 阻断概念 + 推理链 |
| [laubeing-droid/Codex-Claude-legal-cn-mcp-hub](https://github.com/laubeing-droid/Codex-Claude-legal-cn-mcp-hub) | MCP 协议 | 类案检索 + 法条核验 |

## 外部参考（断开但监控）

| 项目 | 引用要点 |
|:-----|:-----|
| ZhouZiai/Multi-agent-system-for-legal-judgment_ | 三角色对抗辩论思路 |
| zhang17173/Event-Extraction | 法律事件要素抽取方法论 |
| jiangxia/ai-trial | 法律角色扮演与庭审流程 |
| shwann/LexSim | 判决预测报告结构与评估指标 |
| nexorin9/medical-trial-simulator | 模块化四层分离架构 |

详见 [REFERENCES.md](REFERENCES.md)

## 许可证

MIT
