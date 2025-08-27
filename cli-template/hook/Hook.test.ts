import { renderHook } from '@testing-library/react-hooks';
import { use$FILE_NAME } from './use$FILE_NAME';

describe('use$FILE_NAME', () => {
  it('should use $FILE_NAME hook', () => {
    const { result } = renderHook(() => use$FILE_NAME());
    // Add your tests here
  });
});
