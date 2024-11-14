import { useState } from 'react';

export const use$FILE_NAME = () => {
  // Lógica del hook aquí
  const [state, setState] = useState(null);

  return { state, setState };
};