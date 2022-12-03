'use strict';

const AWS = require('aws-sdk');

AWS.config.update({
    region: 'ap-northeast-2',
    endPoint: 'http://dynamodb.ap-northeast-2.amazonaws.com'
});

const docClient = new AWS.DynamoDB.DocumentClient();
const TableName =  'ourtable';

module.exports.update = async (event, callback) => {
    
    let  group  = 0
    const user_id = event['rpi_num'];
    //const user_id = 1;
    const detection = true;
    console.log(typeof user_id,user_id);

    const params = {
        TableName : TableName,
        Key : {
            "group": group,
            "user_id": user_id,
        },
        UpdateExpression: "set detection = :d",
        ExpressionAttributeValues: {
            ":d": detection
        },
    }

    const result = await docClient.update(params).promise();

    const response = {
        statusCode: 200,
        body: JSON.stringify(
            {
              message: 'Rpi signal Update successfully!',
              input: {"user_id":user_id,"detection":true},
            }),
    }

    return response;
}