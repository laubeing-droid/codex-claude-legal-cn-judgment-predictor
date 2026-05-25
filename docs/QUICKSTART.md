# 快速开始

## 前提

- Codex Desktop 已安装
- [laubeing-droid/Claude-for-Legal-CN-to-Codex](https://github.com/laubeing-droid/Claude-for-Legal-CN-to-Codex) 已部署（知识库）
- [laubeing-droid/Codex-Claude-legal-cn-mcp-hub](https://github.com/laubeing-droid/Codex-Claude-legal-cn-mcp-hub) 已部署（MCP 工具，可选）

## 安装

```powershell
# 1. 克隆本仓库
git clone https://github.com/laubeing-droid/Codex-Legal-CN-Judgment-Predictor.git
cd Codex-Legal-CN-Judgment-Predictor

# 2. 将 SKILL.md 导入 Codex 技能目录
#    方式 A：复制到 ~/.codex/skills/legal-judgment-predictor/
#    方式 B：在 Codex 中 @legal-judgment-predictor 触发自动加载
```

## 使用

### 在 Codex Desktop 中

```
@legal-judgment-predictor 甲公司与乙公司签订供货合同，约定甲公司向乙公司供应100吨钢材，货到付款。
乙公司收到货物后，以钢材质量不符合约定标准为由拒绝付款。甲公司认为钢材符合国家标准，要求乙公司支付货款及违约金共计120万元。
```

### 降级使用（无知识库/MCP）

即使未安装配套仓库，框架仍可运行：
- 无知识库：法条引用基于 LLM 训练数据，标注 `[需核验]`
- 无 MCP：跳过类案检索，标注 `[无MCP-类案未检索]`
- 置信度自动降低一级

## 输出示例

```markdown
# 裁判预测报告

案由：买卖合同纠纷
预测时间：2026-05-25

## 判决预测

结果方向：🟡 较可能胜诉（部分支持）
置信度：75%

量化预测：
- 货款本金：100万元（极可能支持）
- 违约金：10-20万元（取决于质量争议认定）

关键因子：
| 对原告有利                    | 对被告有利              |
| 合同明确约定货到付款            | 被告主张质量不符        |
| 国家标准可作为质量依据          | 违约金可能被调减        |
```
