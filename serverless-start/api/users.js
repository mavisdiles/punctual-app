'use strict';

const AWS = require('aws-sdk');

AWS.config.update({
    region: 'ap-northeast-2',
    endPoint: 'http://dynamodb.ap-northeast-2.amazonaws.com'
});

const docClient = new AWS.DynamoDB.DocumentClient();
const TableName =  'ourtable';

module.exports.get = async (event, callback) => {
    let queryParam = event.queryStringParameters;
    let  group  = Number(queryParam['group']);
    const user_id = Number(queryParam['user_id']);

    const params = {
        TableName : TableName,
        Key : {
            "group": group,
            "user_id": user_id,
        }
    }

    const result = await docClient.get(params).promise();

    const response = {
        statusCode: 200,
        body: JSON.stringify(result)
    }

    return response;
}

module.exports.list = async (event, callback) => {
    const { group } = event.pathParameters;

    const params = {
        TableName: TableName,
        KeyConditionExpression: "#group = :group",
        ExpressionAttributeNames: {
            "#group": "group"
        },
        ExpressionAttributeValues: {
            ":group": Number(group)
        }
    }

    const result = await docClient.query(params).promise();
    const response = {
        statusCode: 200,
        body: JSON.stringify(result['Items'])
    }

    console.log(result);

    return response;
}

module.exports.update = async (event, callback) => {
    let queryParam = event.queryStringParameters;
    let  group  = Number(queryParam['group']);
    const user_id = Number(queryParam['user_id']);
    const arrive_time = queryParam['arrive_time'];

    const params = {
        TableName : TableName,
        Key : {
            "group": group,
            "user_id": user_id,
        },
        UpdateExpression: "set arrive_time = :a",
        ExpressionAttributeValues: {
            ":a": arrive_time
        },
    }

    const result = await docClient.update(params).promise();

    const response = {
        statusCode: 200,
        body: JSON.stringify(result)
    }

    return response;
}