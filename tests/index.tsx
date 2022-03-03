import React from "react";
import ReactDOM from "react-dom";
import { JSGDHost } from "@kronbergerspiele/jsgdbridge";

function App() {
  const reportScore = React.useCallback((score: number) => {
    console.log(score);
  }, []);
  return (
    <div>
      <h1>app</h1>
      <JSGDHost
        playerName="Johnny"
        prefix="http://localhost:8000"
        reportScore={reportScore}
      />
    </div>
  );
}

const app = document.getElementById("app");
ReactDOM.render(<App />, app);
