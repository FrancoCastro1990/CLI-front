import { useState } from 'react';

export const use$FILE_NAME = () => {
  // Hook logic here
  const [state, setState] = useState(null);

  return { state, setState };
};