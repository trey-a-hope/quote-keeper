import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// https://crontab.guru/

admin.initializeApp(functions.config().firebase);

// Runs every minute.
export const sendDailyNotificationToUsers = functions.pubsub.schedule('* * * * *').timeZone('America/New_York').onRun(async (context) => {
    const users = await admin.firestore().collection('users').get();

    //Iterate over each user in the database.
    await Promise.all(users.docs.map(
        (userDoc) => {
            //Extract data from user document.
            const data = userDoc.data();

            if (data['uid'] === 'Rdi7d2Sv50MqTjLJ384jW44FSRz2') {

                //Add coins to user.
                userDoc.ref.update({ 'coins': admin.firestore.FieldValue.increment(1) });

                //Send notification to user.
                if (data['fcmToken'] !== null) {
                    //Create payload. 
                    var message = {
                        notification: {
                            title: 'HAPPY FRIDAY!',
                            body: `You just received free coins!`,
                        },
                    };

                    //Send message.
                    admin.messaging().sendToDevice(data['fcmToken'], message);
                }
            }
        }
    ));
    return null;
});