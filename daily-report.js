/**
 * 每日早报生成器
 * 用途：生成并发送每日早报（含天气）
 */

const { exec } = require('child_process');
const util = require('util');
const execPromise = util.promisify(exec);

// 获取上海天气
async function getWeather() {
  try {
    const { stdout } = await execPromise('curl -s "wttr.in/Shanghai?format=%l:+%c+%t+%h+%w+%m"');
    return stdout.trim();
  } catch (error) {
    return '上海天气数据获取失败';
  }
}

// 获取详细天气
async function getDetailedWeather() {
  try {
    const { stdout } = await execPromise('curl -s "wttr.in/Shanghai?1&format=%l:%0A%t+%c%0A湿度:%h%0A风速:%w%0A体感:%f"');
    return stdout.trim();
  } catch (error) {
    return '上海天气数据获取失败';
  }
}

// 早报模板
const generateMorningReport = async (date) => {
  const dateStr = date.toLocaleString('zh-CN', {
    timeZone: 'Asia/Shanghai',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    weekday: 'long'
  });

  const weather = await getDetailedWeather();

  return `
📰 《露娜的每日早报》

━━━━━━━━━━━━━━━━━━━━━━━━

📅 ${dateStr}

━━━━━━━━━━━━━━━━━━━━━━━━

🌤️ 今日天气

${weather}

━━━━━━━━━━━━━━━━━━━━━━━━

🌅 早晨寄语

早上好，主人新的一天开始啦！☀️
今天也要元气满满哦～✨

━━━━━━━━━━━━━━━━━━━━━━━━

📰 今日科技要闻

[正在为您获取最新科技新闻...]

━━━━━━━━━━━━━━━━━━━━━━━━

🤖 AI行业动态

[正在为您获取最新AI资讯...]

━━━━━━━━━━━━━━━━━━━━━━━━

💡 今日提醒

• 💊 记得按时吃药哦（09:00 / 15:00 / 23:00）
• 💧 多喝水，保持健康
• 🌙 晚上早点休息

━━━━━━━━━━━━━━━━━━━━━━━━

🐱 露娜的祝福

愿主人的今天充满收获和快乐！
有任何需要，随时呼唤露娜喵～💜

━━━━━━━━━━━━━━━━━━━━━━━━
🔖 露娜数码使魔 · 主人专属早报
`;
};

module.exports = {
  generateMorningReport,
  getWeather,
  getDetailedWeather
};
