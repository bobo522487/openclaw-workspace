---
name: remindme
description: "⏰ simple Telegram reminders for OpenClaw. Use natural language to set reminders like 'in 5 minutes' or 'tomorrow at 9am'."
tags: [telegram, cron, reminders, productivity, schedule]
---

# ⏰ Remind Me

Set reminders in Telegram using normal human language.

## 🚀 How to Use

Just type what you want and when:

- `/remindme in 10 minutes`
- `/remindme tomorrow at 9am standup`
- `/remindme in 2 hours turn off oven`

No menus. No setup. No thinking.

## 💡 Daily Recurring Reminders

For recurring reminders at the same time every day, create separate reminders:

```
/remindme every day at 9am take medicine
/remindme every day at 15:00 take medicine
/remindme every day at 23:00 take medicine
```

This will create 3 separate cron jobs that run daily at the specified times.

## ✨ Examples

**Morning reminder:**
```
/remindme every day at 9am take breakfast medicine
```

**Afternoon reminders:**
```
/remindme every day at 15:00 take lunch medicine
/remindme every day at 18:00 take dinner medicine
```

**Night reminder:**
```
/remindme every day at 23:00 take night medicine
```

## 🛠️ Troubleshooting

If a reminder doesn't work, check:
- `openclaw cron list` - see all scheduled jobs
- Make sure the time format is correct (use "15:00" for 3pm, not "3pm")

## 🔒 Notes

- Reminders are stored as OpenClaw cron jobs
- All reminders send messages to your Telegram
- Reminders don't require you to keep the app open
