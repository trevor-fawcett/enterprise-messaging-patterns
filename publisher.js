var AWS = require('aws-sdk');
AWS.config.loadFromPath('../enterprise-messaging-patterns-aws-config.json');

var params = {
  Message: 'Testing', /* required */
  // MessageAttributes: {
  //   '<String>': {
  //     DataType: 'STRING_VALUE', /* required */
  //     BinaryValue: new Buffer('...') || 'STRING_VALUE',
  //     StringValue: 'STRING_VALUE'
  //   },
  // },
  MessageStructure: 'string',
  TopicArn: 'arn:aws:sns:eu-west-2:627160346742:dispatcher'
};

var sns = new AWS.SNS();

sns.publish(params, function(err, data) {
  if (err) console.log(err, err.stack); // an error occurred
  else     console.log(data);           // successful response
});