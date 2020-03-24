fetch("a.wasm")
    .then(response => response.arrayBuffer())
    .then(bytes => WebAssembly.instantiate(bytes))
    .then(response => {
        let result = response.instance.exports.add(1,6);
        console.log(result);
    });
    

