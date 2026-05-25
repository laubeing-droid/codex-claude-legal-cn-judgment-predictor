# 引用来源

本框架设计参考了以下开源项目，特此致谢。

## 学术/技术引用

| 项目 | 作者 | 许可证 | 引用要点 |
|:-----|:-----|:-----|:-----|
| [Multi-agent-system-for-legal-judgment_](https://github.com/ZhouZiai/Multi-agent-system-for-legal-judgment_) | ZhouZiai | 开源 | 三角色对抗辩论框架（原告律师/被告律师/法官）的批判性推理思路 |
| [Event-Extraction](https://github.com/zhang17173/Event-Extraction) | zhang17173 | 开源 | 法律事件要素结构化抽取方法论（主观动机/客观行为/事后情况） |
| [ai-trial](https://github.com/jiangxia/ai-trial) | jiangxia | 开源 | LLM Prompt 驱动的法律角色扮演与庭审流程设计 |
| [LexSim](https://github.com/shwann/LexSim) | shwann | 开源 | 判决预测报告结构、多维度评估指标体系、庭审轮次编排设计 |
| [medical-trial-simulator](https://github.com/nexorin9/medical-trial-simulator) | nexorin9 | MIT | 模块化架构模板：prompts/trial/evaluator/report 四层分离设计 |

## 联动项目

| 项目 | 用途 |
|:-----|:-----|
| [laubeing-droid/Claude-for-Legal-CN-to-Codex](https://github.com/laubeing-droid/laubeing-droid/Claude-for-Legal-CN-to-Codex) | 法律知识注入：law-semantic-tree.json + blocking-list.md + reasoning-template-zh.md |
| [laubeing-droid/Codex-Claude-legal-cn-mcp-hub](https://github.com/laubeing-droid/laubeing-droid/Codex-Claude-legal-cn-mcp-hub) | MCP 工具联动：案例库检索 + 国家法规库核验 + 元典智库综合检索 |
| [laubeing-droid/PRC-US-Legal-Semantic-Alignment-Framework](https://github.com/laubeing-droid/laubeing-droid/PRC-US-Legal-Semantic-Alignment-Framework) | 中美法律概念映射框架（29 项阻断清单上游） |

## 免责声明

本框架中的角色 Prompt、辩论流程、评估维度为独立设计，
不包含上述项目的源代码。外部项目引用仅表示设计思路层面的参考和致谢，运行时不依赖外部项目。