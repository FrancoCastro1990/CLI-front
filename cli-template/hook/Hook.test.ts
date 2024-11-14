import { renderHook } from '@testing-library/react-hooks';
import { use$FILE_NAME } from './use$FILE_NAME';

describe('use$FILE_NAME', () => {
  it('should use Hook hook', () => {
    const { result } = renderHook(() => use$FILE_NAME());
    // Añade tus pruebas aquí
  });
});
