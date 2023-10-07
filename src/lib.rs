use std::ffi::{c_int, c_uint, c_void};

#[derive(Clone, Copy)]
struct UnsafeSendSync<T>(T);

unsafe impl<T> Send for UnsafeSendSync<T> {}

unsafe impl<T> Sync for UnsafeSendSync<T> {}

impl<T> UnsafeSendSync<T>
{
    unsafe fn new(value: T) -> Self
    {
        Self(value)
    }

    fn into_inner(self) -> T
    {
        self.0
    }
}

#[no_mangle]
unsafe extern fn omp_get_num_threads() -> c_int
{
    rayon_core::current_num_threads()
        .try_into()
        .unwrap_or(c_int::MAX)
}

#[no_mangle]
unsafe extern fn omp_get_thread_num() -> c_int
{
    rayon_core::current_thread_index()
        .unwrap_or(0)
        .try_into()
        .unwrap_or(0)
}

#[no_mangle]
unsafe extern fn GOMP_parallel(
    r#fn: unsafe extern fn(*mut c_void),
    data: *mut c_void,
    num_threads: c_uint,
    flags: c_uint,
)
{
    if num_threads != 0 { todo!("num_threads: {num_threads}") }
    if flags != 0 { todo!("flags: {flags:x}") }
    let data = UnsafeSendSync::new(data);
    rayon_core::broadcast(|_| r#fn(data.into_inner()));
}
