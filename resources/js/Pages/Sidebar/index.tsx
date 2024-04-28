import React, {useEffect, useState} from "react";
import axios from "axios";
import Loader from "@/Components/Loader";

async function fetchTags() {

    let config = {
        method: 'get',
        maxBodyLength: Infinity,
        url: '/api/tags',
        headers: {
            'Accept': 'application/json',
        },
    };

    return axios.request(config)
}

function Sidebar({tags, setTags, filters, setFilters, search, setSearch, setParams, className}: any) {

    const [loading, setLoading] = useState(false)

    useEffect(() => {
        setLoading(true)
        fetchTags().then(value => {
            setTags(value.data)
        }).catch(reason => {
            alert(JSON.stringify(reason?.message))
        }).finally(() => {
            setLoading(false)
        })
    }, []);

    function handleTags(slug: string, checked: boolean) {
        if (checked) {
            const uniqueSet = new Set(filters);
            if (!uniqueSet.has(slug)) {
                uniqueSet.add(slug);
                const filteredArray = Array.from(uniqueSet);
                setFilters(filteredArray);
                setParams((prevState: any) => ({
                    ...prevState,
                    tags: filteredArray.join(',')
                }))
            }
        } else {
            const filteredArray = filters.filter((val: string) => val !== slug);
            setFilters(filteredArray);
            setParams((prevState: any) => ({
                ...prevState,
                tags: filteredArray.join(',')
            }))
        }
    }

    function handleFilterTag(slug: string) {
        const filteredArray = filters.filter((val: string) => val !== slug);
        setFilters(filteredArray);
        setParams((prevState: any) => ({
            ...prevState,
            tags: filteredArray.join(',')
        }))
    }

    function handleClearAll() {
        setFilters([]);
        setParams((prevState: any) => ({
            ...prevState,
            tags: ''
        }))
    }

    function handleSearch(e: any){
        e.preventDefault();
        setParams((prevState: any) => ({
            ...prevState,
            search: String(search || '').trim()
        }))
    }

    return (
        <div
            className={`${className || 'sidebar sticky hidden h-full lg:pt-4 shrink-0 ltr:pr-8 rtl:pl-8 xl:ltr:pr-16 xl:rtl:pl-16 lg:block w-80 xl:w-50 top-16 pr-4'}`}>
            <div className="space-y-10">
                <div className="block -mb-3">
                    <div className="mb-8 -mt-1">
                        <h2 className={'text-brand-dark text-15px sm:text-base font-semibold mb-2'}>Search Title</h2>
                        <form className={'relative'} method={'get'} autoComplete={'off'} action={''}
                        onSubmit={handleSearch}>
                            <input type="text"
                                   className="w-full border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                   value={search}
                                   onChange={(e) => setSearch(e.target.value)}
                            />
                            <button type="submit"
                                    className="absolute inset-y-0 right-0 px-4 py-2 bg-blue-500 text-white rounded-r-md shadow-sm hover:bg-blue-600 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                Search
                            </button>
                        </form>
                    </div>

                    {(filters.length > 0) && (
                        <div className="flex items-center justify-between mb-4 -mt-1">
                            <h2 className={'text-brand-dark text-15px sm:text-base font-semibold'}>Filters</h2>
                            <button
                                type={'button'}
                                className="flex-shrink transition duration-150 ease-in text-13px focus:outline-none hover:text-brand-dark
                            text-[#4b5563]"
                                aria-label="Clear All"
                                onClick={handleClearAll}
                            >Clear All
                            </button>
                        </div>
                    )}
                    <div className="flex flex-wrap -m-1">
                        {(filters.length > 0) && (
                            <>
                                {filters.map((item: string, index: number) => (
                                    <div
                                        key={`filter-tag-${item}-${index}`}
                                        className="group flex shrink-0 m-1 items-center border border-border-base rounded-lg text-13px px-2.5 py-1.5 capitalize text-brand-dark cursor-pointer transition duration-200 ease-in-out hover:border-brand"
                                        onClick={() => handleFilterTag(item)}
                                    >{item}
                                        <svg stroke="currentColor" fill="currentColor" strokeWidth={0}
                                             viewBox="0 0 512 512"
                                             className="text-sm text-body ltr:ml-2 rtl:mr-2 shrink-0 ltr:-mr-0.5 rtl:-ml-0.5 mt-0.5 transition duration-200 ease-in-out group-hover:text-heading"
                                             height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="m289.94 256 95-95A24 24 0 0 0 351 127l-95 95-95-95a24 24 0 0 0-34 34l95 95-95 95a24 24 0 1 0 34 34l95-95 95 95a24 24 0 0 0 34-34z"></path>
                                        </svg>
                                    </div>
                                ))}
                            </>
                        )}
                    </div>
                </div>
                <div className="block">
                    <h3 className="text-brand-dark text-15px sm:text-base font-semibold mb-5 -mt-1">Tags</h3>
                    {loading && (
                        <Loader/>
                    ) || (
                        <>
                            {tags.length > 0 && (
                                <>
                                    {tags.map((tag: any, index: number) => (
                                        <div className="flex flex-col mb-2" key={`tag-${tag.id}-${index}`}>
                                            <label>
                                                <input
                                                    className="form-checkbox text-black-100 w-[22px] h-[22px] border-2 border-border-four cursor-pointer transition duration-500 ease-in-out focus:ring-offset-0 hover:border-black-100 focus:outline-none focus:ring-0 focus-visible:outline-none checked:bg-black-100 hover:checked:bg-black-100"
                                                    type="checkbox"
                                                    value={tag.slug}
                                                    name={tag.name}
                                                    checked={tag.slug === filters.find((val: string) => val === tag.slug)}
                                                    onChange={(event) => {
                                                        handleTags(tag.slug, event.target.checked);
                                                    }}
                                                />
                                                <span
                                                    className="ltr:mr-3.5 rtl:ml-3.5 -mt-0.5 ml-2 cursor-pointer capitalize">
                                                       {tag.name}
                                                    </span>
                                            </label>
                                        </div>
                                    ))}
                                </>
                            ) || (
                                <div>Not Found!</div>
                            )}
                        </>
                    )}
                </div>
            </div>
        </div>
    )
}

export default Sidebar
