import React from "react";
import { $FILE_NAMEContext } from "./$FILE_NAMEContext";

//Provider
//Define context values here
export const $FILE_NAMEProvider = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  // Context logic here

  return (
    <$FILE_NAMEContext.Provider value={{ example: "hi" }}>
      {children}
    </$FILE_NAMEContext.Provider>
  );
};
