export EXAMPLE_NAME=$1
cargo build --example $1 --target wasm32-unknown-unknown --release;
wasm-bindgen --target web --out-dir web --no-typescript target/wasm32-unknown-unknown/release/examples/$1.wasm
envsubst <<EOF > $1.html
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  </head>
  <body>
    <script type="module">
      import init from "./web/${EXAMPLE_NAME}.js";
      window.addEventListener("load", () => {
        init();
      });
    </script>
  </body>
</html>
EOF

cp $1.html index.html

