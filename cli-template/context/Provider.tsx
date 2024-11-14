import React from "react";
import { $FILE_NAMEContext } from "./$FILE_NAMEContext";

//Provider
//Definir los valores de contexto aquí
export const $FILE_NAMEProvider = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  // Lógica del contexto aquí

  return (
    <$FILE_NAMEContext.Provider value={{ example: "hi" }}>
      {children}
    </$FILE_NAMEContext.Provider>
  );
};
