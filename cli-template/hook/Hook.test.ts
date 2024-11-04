import { renderHook } from '@testing-library/react-hooks';
import { $FILE_NAME } from './$FILE_NAME';

describe('$FILE_NAME', () => {
  it('should use Hook hook', () => {
    const { result } = renderHook(() => $FILE_NAME());
    // Añade tus pruebas aquí
  });
});
