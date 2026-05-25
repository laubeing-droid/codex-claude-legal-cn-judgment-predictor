# Codex-Legal-CN-Judgment-Predictor

> 中国法裁判预测框架 — 输入案件事实，输出结构化判决预测

基于三角色对抗辩论（原告/被告→法官综合裁决），纯 Prompt 驱动，无需模型训练。
与 [laubeing-droid/Claude-for-Legal-CN-to-Codex](https://github.com/laubeing-droid/Claude-for-Legal-CN-to-Codex) 知识库和 [laubeing-droid/Codex-Claude-legal-cn-mcp-hub](https://github.com/laubeing-droid/Codex-Claude-legal-cn-mcp-hub) 联动。

## 工作流

```
案件事实 → 要素抽取 → 原告论证 → 被告抗辩 → 法官裁决 → 自评 → 报告
              │                          │
              └── 类案检索(MCP) ──────────┘
```

## 目录结构

```
├── SKILL.md              # Codex 技能入口
├── README.md
├── prompts/
│   ├── plaintiff.md      # 原告/公诉方视角
│   ├── defendant.md      # 被告/辩护方视角
│   └── judge.md          # 法官综合裁决
├── extract/
│   └── fact-elements.md  # 事实要素结构化抽取
├── debate/
│   └── rounds.md         # 3 轮对抗辩论编排
├── predict/
│   ├── civil.md          # 民事判决预测
│   ├── criminal.md       # 刑事判决预测
│   └── admin.md          # 行政判决预测
├── evaluate/
│   └── metrics.md        # 多维度自评
├── report/
│   └── template.md       # 结构化预测报告模板
└── mcp/
    └── linkage.md        # MCP Hub 联动
```

## 依赖

| 依赖 | 仓库 | 用途 |
|:-----|:-----|:-----|
| 知识库 | [laubeing-droid/Claude-for-Legal-CN-to-Codex](https://github.com/laubeing-droid/Claude-for-Legal-CN-to-Codex) | 法条要件 + 阻断概念 + 推理链 |
| MCP 工具 | [laubeing-droid/Codex-Claude-legal-cn-mcp-hub](https://github.com/laubeing-droid/Codex-Claude-legal-cn-mcp-hub) | 类案检索 + 法条核验 |

## 使用

在 Codex Desktop 中：

```
@legal-judgment-predictor [案件事实描述]
```

CLI 模式：

```
将 SKILL.md 内容作为 System Prompt，输入案件事实。
模型按工作流自动执行全流程。
```

## 引用来源

详见 [REFERENCES.md](REFERENCES.md)

## 许可证

MIT