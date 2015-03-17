var count = 0

function sendCount(){
	var message = {"count":count}
	window.webkit.messageHandlers.interOp.postMessage(message)
}

function storeAndShow(updatedCount){
	count = updatedCount
	document.querySelector("#resultDisplay").innerHTML = count
}
