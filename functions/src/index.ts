import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// export const sendToTopic = functions.firestore.document("puppies/{puppyId}").onCreate(async snapshot => {

//     const puppy = snapshot.data();

//     const payload: admin.messaging.MessagingPayload = {notification:{title:"New Puppy!",body:`${puppy.name} is ready to die!`,clickAction:"FLUTTER_NOTIFICATION_CLICK",},}

//     return fcm.sendToTopic("puppies",payload);
// });


// export const sendToDevice = functions.firestore.document("order/{orderId}").onCreate(async snapshot => {
//     // Get the uploaded data 
//     const order = snapshot.data();


//     // Get the token from every customer base on order"s phone number
//     const querySnapshot =await db.collection("customer").doc(order.phone_number).collection("tokens").get();
//     // Create a list of tokens registered in my phone number
//     const tokens = querySnapshot.docs.map((snap)=> snap.id);
//     // Create a payload base what you want to show
//     const payload: admin.messaging.MessagingPayload = {notification:{title:"StorageX Smartlockers Update!",body:`Available now on Playstore and Appstore #${snapshot.id}`},}

//     return fcm.sendToDevice(tokens,payload);
// });
export const revenueShareAdjuster = functions.firestore.document("users/{uid}").onUpdate(async snapshot => {
  // Get the uploaded data 
  const data = snapshot.after.data();
  //Get the uid of the user for reference later
  const uid = data.uid
  //Get the client shares and then convert to float for math purpose

  //Compute the sx share depends on the client share

  if (data.client_share == '.100') {
    return db.collection('users').doc(uid).update({ 'sx_share': `.0` })
  } else {
    const clientShareFloat = parseFloat(data.client_share)

    const sxShare = (100 - (clientShareFloat * 100))
    //Upload now the sx share
    return db.collection('users').doc(uid).update({ 'sx_share': `.${sxShare}` })
  }
});

export const sendOtpToDevice = functions.firestore.document("customer/{phoneNumber}/otp/{referenceId}").onCreate(async snapshot => {
  // Get the uploaded data 
  const otp = snapshot.data();


  // Get the token from every customer base on order"s phone number
  const querySnapshot = await db.collection("customer").doc(otp.mobile_number).collection("tokens").get();
  // Create a list of tokens registered in my phone number
  const tokens = querySnapshot.docs.map((snap) => snap.data().token);
  // Create a payload base what you want to show
  const payload: admin.messaging.MessagingPayload = { notification: { title: `${otp.claim_code} 🔐`, body: `Please keep your claim code confidential to ensure the safety of your package!` }, }

  return fcm.sendToDevice(tokens, payload);
});

export const sendOtpClaimedOrExpiredToDevice = functions.firestore.document("customer/{phoneNumber}/otp/{referenceId}").onUpdate(async snapshot => {
  // Get the uploaded data 
  const before = snapshot.before.data();
  const after = snapshot.after.data();
  const isClaimed = after.status === '1';
  // const isExpired = after.status === '2';


  // Get the token from every customer base on order"s phone number
  const querySnapshot = await db.collection("customer").doc(before.mobile_number).collection("tokens").get();
  // Create a list of tokens registered in my phone number
  const tokens = querySnapshot.docs.map((snap) => snap.data().token);
  // Create a payload base what you want to show
  const payload: admin.messaging.MessagingPayload = {

    notification: {
      title: `${isClaimed ? 'Successful Transaction! 🥳' : 'Expired Transaction 🙁'}`,
      body: `${isClaimed ? 'Your package was claimed. Thank you for using StorageX Smartlockers!' : 'Your claim code has expired. Please contact the building admin for assistance concerning with your abandoned package.'}`
    },
  }

  return fcm.sendToDevice(tokens, payload);
});