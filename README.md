# Janitor AI Claude proxy

Set Janitor AI's proxy to `https://api.plan2api.com/v1/chat/completions` with your `p2a_` key and the model `claude/claude-sonnet-5`, and Janitor runs on the Claude Pro or Max subscription you already pay for. No Anthropic API key, no OpenRouter credits and no per-message bill: [Plan2API](https://plan2api.com/integrations/janitor-ai) turns your subscription into the OpenAI-compatible endpoint Janitor's proxy option expects.

The same proxy runs GPT on your ChatGPT Plus or Pro plan (`openai/gpt-6.1-sol`), Gemini on Google AI Pro (`gemini/gemini-3.8-flash-high`) and Kimi Code (`kimi/k3`).

**[Get a free `p2a_` key](https://plan2api.com/connect?utm_source=github&utm_medium=readme&utm_campaign=janitor-ai-claude-proxy)** | [Janitor AI guide on plan2api.com](https://plan2api.com/integrations/janitor-ai) | [API reference](https://plan2api.com/docs)

## Copy these into Janitor

| Janitor field | Value |
| --- | --- |
| Config Name | `Plan2API Claude` (any name works) |
| Model Name | `claude/claude-sonnet-5` |
| Proxy URL | `https://api.plan2api.com/v1/chat/completions` |
| API Key | your `p2a_...` key, no spaces |
| Custom Prompt | leave blank |

The Proxy URL has to be the full `/v1/chat/completions` address. A URL that stops at `/v1` fails.

## What is a proxy in Janitor AI?

Janitor's own model is JanitorLLM (JLLM). The proxy option swaps it for any OpenAI-compatible Chat Completions endpoint you point it at. Plan2API is that endpoint, backed by the Claude, ChatGPT, Gemini or Kimi subscription you connect, so Claude writes your replies instead of JLLM.

## Setup in 3 minutes

### 1. Get your `p2a_` key

1. Open [plan2api.com/connect](https://plan2api.com/connect?utm_source=github&utm_medium=readme&utm_campaign=janitor-ai-claude-proxy) and sign up with Google.
2. Connect Claude by signing in with your Claude account on Anthropic's own sign-in page. Pro, Max 5x and Max 20x all work.
3. Copy the `p2a_` key shown after connecting. It is shown once, so save it; you can create more on the Keys page (`plan2api.com/dashboard/keys`).

### 2. Add the proxy in Janitor AI

1. Open any chat and click the gear icon at the top right.
2. Go to **API Settings**, choose **Proxy**, then click **Add Configuration**.
3. Fill in **Config Name**, **Model Name**, **Proxy URL** and **API Key** from the table above, and leave **Custom Prompt** blank.
4. Click **Add**, then **Save Settings**.
5. Refresh the page (F5 on desktop, pull down on mobile). Janitor only picks up a new proxy after a refresh.
6. Send a test message.

Skip the **Check Key/Model** button. Janitor's own help center calls it buggy, and it can show "Network Error" on a perfectly good setup. Save and refresh instead.

### 3. Add one configuration per model

Create a second configuration with Model Name `claude/claude-opus-5-5` for heavier scenes, or `openai/gpt-6.1-sol` for GPT on your ChatGPT plan, and switch by activating the one you want. If a config stops answering, run Janitor's own fix-it routine: make sure it says **Active**, click **Save Settings**, refresh the page, then reopen the config and click **Test**.

## Models

| Model Name | Runs on | Context window |
| --- | --- | --- |
| `claude/claude-sonnet-5` | Claude Pro or Max | 1,000,000 (up to 128K output) |
| `claude/claude-opus-5-5` | Claude Pro or Max | 1,000,000 (up to 128K output) |
| `openai/gpt-6.1-sol` | ChatGPT Plus or Pro (Codex) | listed by `GET /v1/models` |
| `gemini/gemini-3.8-flash-high` | Google AI Pro or Ultra | 1,048,576 |
| `kimi/k3` | Kimi Code membership | 1,048,576 |

`anthropic/` works in place of `claude/`, dotted names such as `claude/claude-opus-5.5` resolve too, and `codex/<model>` works for GPT. Janitor's Temperature setting only changes Gemini replies: Claude and Codex ignore `temperature` and `top_p`, and Kimi fixes them at 1 and 0.95.

## Test your key outside Janitor

[`test-proxy.sh`](test-proxy.sh) sends one request with the same URL, key and model Janitor uses:

```bash
PLAN2API_KEY=p2a_your_key bash test-proxy.sh claude/claude-sonnet-5
```

A JSON reply with `choices` means the key and model are good, and anything still failing is in the Janitor config.

## Troubleshooting

| What you see | Why | Fix |
| --- | --- | --- |
| `Failed to fetch` (Firefox: `NetworkError when attempting to fetch resource`, Safari: `Load failed`) | The browser got no usable answer: the page wasn't refreshed after saving, the Proxy URL has a typo or stray space, or an ad blocker ate the request | Save Settings, refresh, recheck the URL, or try once in a private window. Plan2API sends CORS headers, so CORS is not the cause |
| `404` `not_found` | The Proxy URL stops at `/v1` | Use `https://api.plan2api.com/v1/chat/completions` |
| `401` `invalid_api_key` | Key missing, mistyped or revoked | Paste the key again with no spaces, or create a new one |
| `non ISO-8859-1 code point` | A hidden character slipped into the API Key field (common when copying on a phone) | Clear the field and paste the key again as plain text |
| `403` `no_credentials` | The model's provider isn't connected to your Plan2API account | Connect it at plan2api.com, or switch Model Name to a `claude/` id |
| `400` `model_not_found` | Typo or missing prefix in Model Name | Use the exact id, for example `claude/claude-sonnet-5` |
| `429` `subscription_quota_exhausted` | Your Claude plan hit its 5-hour or weekly limit | Wait for the time in the error message, or connect another Claude account for automatic failover |
| `pgshag2`, an empty reply or a reply cut off mid-sentence | A provider content filter, most often on Gemini | Rephrase, or switch Model Name to a Claude model |
| "Network Error" after **Check Key/Model** | That button is buggy | Ignore it, Save Settings and refresh |

## FAQ

### What is a Claude proxy for Janitor AI?

It's an OpenAI-compatible endpoint that Janitor sends your chats to instead of JanitorLLM. With Plan2API, that endpoint runs on your own Claude Pro or Max subscription, so you get Claude replies without paying per token.

### How do I use Claude on Janitor AI?

Connect your Claude subscription at plan2api.com, then add a proxy configuration in Janitor with Proxy URL `https://api.plan2api.com/v1/chat/completions`, your `p2a_` key and Model Name `claude/claude-sonnet-5`. Save, refresh and chat.

### What proxy URL do I use for Claude in Janitor AI?

`https://api.plan2api.com/v1/chat/completions`, written out in full. Janitor posts to the URL exactly as typed.

### Can I use my Claude Pro subscription on Janitor AI?

Yes. Pro, Max 5x and Max 20x all work, and replies count against your Claude plan's usage limits instead of an API bill.

### Do I need an Anthropic API key for Janitor AI?

No. Plan2API signs in with your Claude account on Anthropic's own page and gives you a `p2a_` key; that is the only key Janitor needs.

### Can I use GPT on Janitor AI with ChatGPT Plus?

Yes. Connect ChatGPT in Plan2API with a one-time device code, then make a second proxy config with Model Name `openai/gpt-6.1-sol`. Same Proxy URL, same key.

### Is the proxy free?

The proxy itself is: Plan2API's Free plan is $0 with one connected subscription, no card and no daily request cap, and your chats run on the Claude plan you already pay for. Pro ($12 a month) connects 3 subscriptions for failover and higher rate limits. See [pricing](https://plan2api.com/pricing).

### Do I have to refresh Janitor AI after changing the proxy?

Yes. Click **Save Settings**, then refresh the whole page; Janitor keeps using the old settings until you do.

### Does it work on mobile?

Yes. Janitor runs in the browser, so the setup is identical on a phone: save, pull down to refresh, chat.

## More guides

- [Janitor AI + Plan2API guide](https://plan2api.com/integrations/janitor-ai)
- [Janitor AI Claude proxy](https://plan2api.com/janitor-ai-claude-proxy)
- [Janitor AI GPT proxy](https://plan2api.com/janitor-ai-gpt-proxy)
- [Use your Claude subscription as an API](https://plan2api.com/claude-subscription-api)
- [Use your ChatGPT subscription as an API](https://plan2api.com/chatgpt-subscription-api)
- [Claude Pro and Max usage limits](https://plan2api.com/claude-usage-limits)

Same setup, other clients:

- [SillyTavern with a Claude subscription](https://github.com/bitgate/sillytavern-claude-subscription)
- [Open WebUI with a ChatGPT subscription](https://github.com/bitgate/open-webui-chatgpt-subscription)
- [Cline, Roo Code and Kilo Code with a Claude subscription](https://github.com/bitgate/cline-claude-subscription)
- [OpenCode with a Claude Pro or Max subscription](https://github.com/bitgate/opencode-claude-subscription)
