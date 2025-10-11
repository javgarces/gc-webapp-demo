import React from "react";

const App: React.FC = () => {
  const handleClick = () => {
    alert("Hello from frontend!");
  };

  return (
    <div style={{ display: "flex", justifyContent: "center", marginTop: "50px" }}>
      <button onClick={handleClick}>Click me</button>
    </div>
  );
};

export default App;
