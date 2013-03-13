<?php
	/*header('Content-type: application/json');*/

	/* Open the APNs connection. */
	$apnsHost = 'gateway.sandbox.push.apple.com';
	$apnsPort = 2195;
	$apnsCert = 'aps_development.cer';

	$streamContext = stream_context_create();
	stream_context_set_option($streamContext, 'ssl', 'local_cert', $apnsCert);

	$apns = stream_socket_client('ssl://' . $apnsHost . ':' . $apnsPort, $error, 	    $errorString, 2, STREAM_CLIENT_CONNECT, $streamContext);

	/* Loop through and send all queued payloads. */
	$apnsMessage = chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '', 	    $deviceToken)) . chr(0) . chr(strlen($payload)) . $payload;
	fwrite($apns, $apnsMessage);

	/* Close the connection. */
	socket_close($apns);
	fclose($apns);
	
	/*$hash = sha1('vandyvansapp');
	
	if ($_POST['verifyHash'] == $hash) {
		if (validateEmail($_POST['senderAddress'])) {
			$to = 'vandyvansapp@gmail.com';
			$subject = 'Vandy Vans';
		
			if ($_POST['isBugReport']) {
				$subject = $subject . ' Bug Report';
			} else {
				$subject = $subject . ' Feedback';
			}
		
			$body = $_POST['body'];
		
			if ($_POST['notifyWhenResolved']) {
				$body = $body . "\n\n" . 'Notify when issue is resolved.';
			}
				$from = $_POST['senderAddress'];
		
				$headers = "From: ".$from."\r\n"."Reply-To: ".$from."\r\n";
		
				mail($to, $subject, $body, $headers);
			
			echo '{"status":"success"}';
		} else {
			echo '{"status":"invalid email"}';
		}
	} else {
		echo '{"status":"invalid hash"}';
	}*/
?>