import { createContext } from "react";

interface $FILE_NAMEContextProps {
  // Propiedades del contexto aquí
  example?: string;
}

export const $FILE_NAMEContext = createContext<$FILE_NAMEContextProps>({
  // Valores por defecto aquí
  example: "example",
});
