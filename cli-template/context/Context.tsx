import { createContext } from "react";

interface $FILE_NAMEContextProps {
  // Context properties here
  example?: string;
}

export const $FILE_NAMEContext = createContext<$FILE_NAMEContextProps>({
  // Default values here
  example: "example",
});
