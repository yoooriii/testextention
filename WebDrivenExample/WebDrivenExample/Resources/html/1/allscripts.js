"use strict";var index = 0;function testClickFunc (itemId) {	var element = document.getElementById(itemId);    element.innerHTML = "Paragraph changed." + index;    console.log("my log "+element.innerHTML);	index++;	var element2 = document.getElementById("testField");	element2.innerHTML = document.URL;}function testAddChildren (itemId) {	var element = document.getElementById(itemId);	for (var i=0; i<5; ++i) {		var para = document.createElement("p");		var node = document.createTextNode("This is new." + i + " " + navigator.platform);		para.appendChild(node);		element.appendChild(para);	}}