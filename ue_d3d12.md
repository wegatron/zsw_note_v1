typedef enum D3D12_CPU_PAGE_PROPERTY
{
    D3D12_CPU_PAGE_PROPERTY_UNKNOWN = 0,    // Not relevant for custom heaps
    D3D12_CPU_PAGE_PROPERTY_NOT_AVAILABLE = 1, // Not accessible to the CPU at all
    
    // Uncached for the CPU. Write combined for CPU writes, very very slow CPU reads.
    // GPU will read this data over PCIe at low speeds relative to VRAM.
    // Good for passing data from CPU -> GPU
    D3D12_CPU_PAGE_PROPERTY_WRITE_COMBINE = 2,

    // Cached for the CPU with full speed reads and writes.
    // GPU will access this data over PCIe at low speeds relative to VRAM.
    // Good for reading back data from GPU -> CPU.
    // Can be used for CPU -> GPU traffic as well, but may pollute
    // the CPU cache with data that will only be read by the GPU.    
    D3D12_CPU_PAGE_PROPERTY_WRITE_BACK  = 3
} D3D12_CPU_PAGE_PROPERTY;

更方便的方式是设置D3D12_HEAP_TYPE, 然后将MemoryPoolPreference=D3D12_MEMORY_POOL_UNKNOWN, CPUPageProperty=D3D12_CPU_PAGE_PROPERTY_UNKNOWN

UE中D3D12的内存管理

```c++
// Private/D3D12Allocation.h

// frame based memory pool
// do suballocate in page
// if (CurrentAllocatorPage == nullptr || PagePool.GetPageSize() < CurrentOffset + Size)
class FD3D12FastAllocatorPagePool;

// same as D3D12MA pool
class FD3D12DefaultBufferPool;

// > 阈值使用commited resource
class FD3D12TextureAllocator : FD3D12MultiBuddyAllocator


// Private/D3D12Device.h
class FD3D12Device
{
private:
    FD3D12DefaultBufferAllocator DefaultBufferAllocator;
    FD3D12FastAllocator          DefaultFastAllocator;
    FD3D12TextureAllocatorPool   TextureAllocator;
}

// Private/D3D12Adapter.h
// 用来管理和管理多个Device,
// linked D3D12 Device node, In most cases there will be only 1 node.
class FD3D12Adapter
{
private:
    FD3D12UploadHeapAllocator*	UploadHeapAllocator[MAX_NUM_GPUS];
}
```