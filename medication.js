/**
 * 吃药提醒助手
 * 用途：记录吃药状态，生成带按钮的提醒消息
 */

const fs = require('fs');
const path = require('path');

const STATE_FILE = '/home/node/.openclaw/workspace/medication-state.json';

// 读取状态
function readState() {
  try {
    const data = fs.readFileSync(STATE_FILE, 'utf8');
    return JSON.parse(data);
  } catch (error) {
    return { history: [], lastUpdate: null };
  }
}

// 保存状态
function saveState(state) {
  fs.writeFileSync(STATE_FILE, JSON.stringify(state, null, 2));
}

// 记录吃药状态
function recordMedication(time, status) {
  const state = readState();
  const now = new Date();
  const record = {
    time: time,
    status: status,
    timestamp: now.toISOString(),
    displayTime: now.toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai' })
  };
  state.history.push(record);
  state.lastUpdate = now.toISOString();
  saveState(state);
  return record;
}

// 获取上次的记录
function getLastRecord() {
  const state = readState();
  if (state.history.length === 0) return null;
  return state.history[state.history.length - 1];
}

// 生成带按钮的提醒消息
function generateReminder(currentTime) {
  const lastRecord = getLastRecord();
  let message = `💊 该吃药啦！（${currentTime}）\n\n`;

  if (lastRecord) {
    const statusText = lastRecord.status === 'taken' ? '✅ 已吃' : '❌ 未吃';
    message += `📌 上次 ${lastRecord.time}: ${statusText} (${lastRecord.displayTime.split(' ')[1]})\n\n`;
  }

  return message;
}

module.exports = {
  readState,
  saveState,
  recordMedication,
  getLastRecord,
  generateReminder
};
