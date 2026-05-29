const { DynamoDBClient, PutItemCommand } = require('@aws-sdk/client-dynamodb');
const { randomUUID } = require('crypto');

const client = new DynamoDBClient({});
const TABLE = process.env.TABLE_NAME;

const CORS = {
  'Access-Control-Allow-Origin':  'https://thaer.dev',
  'Access-Control-Allow-Headers': 'content-type',
  'Access-Control-Allow-Methods': 'POST,OPTIONS',
};

exports.handler = async (event) => {
  if (event.requestContext?.http?.method === 'OPTIONS') {
    return { statusCode: 200, headers: CORS, body: '' };
  }

  let body;
  try {
    body = JSON.parse(event.body || '{}');
  } catch {
    return { statusCode: 400, headers: CORS, body: JSON.stringify({ error: 'bad request' }) };
  }

  const { day, food, vibe } = body;
  if (!day || !food || !vibe) {
    return { statusCode: 400, headers: CORS, body: JSON.stringify({ error: 'missing fields' }) };
  }

  const ip = event.requestContext?.http?.sourceIp ?? 'unknown';

  await client.send(new PutItemCommand({
    TableName: TABLE,
    Item: {
      id:         { S: randomUUID() },
      created_at: { S: new Date().toISOString() },
      day:        { S: String(day)  },
      food:       { S: String(food) },
      vibe:       { S: String(vibe) },
      ip:         { S: ip           },
    },
  }));

  return { statusCode: 200, headers: CORS, body: JSON.stringify({ ok: true }) };
};
