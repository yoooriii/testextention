function reqListener() {
	console.log('GOT RESPONSE: ' + this.responseText);
	return;
	var data = JSON.parse(this.responseText);
	console.log(data);
}

function reqError(err) {
	console.log('Fetch Error :-S', err);
}

function runRequest(method, url) {
	var oReq = new XMLHttpRequest();
	oReq.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	oReq.onload = reqListener;
	oReq.onerror = reqError;
	oReq.open(method, url, true);
	oReq.send();
	console.log('request sent\n');
}

//	Objective-C
function printNameAtIndex(index) {
	var myaddressbook = window.AddressBook;
	var name = myaddressbook.nameAtIndex(index);
	document.write(name);
}