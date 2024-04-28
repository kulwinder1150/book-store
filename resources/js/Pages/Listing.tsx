import React, {useEffect, useRef, useState} from 'react';
import Sidebar from "@/Pages/Sidebar";
import axios from "axios";
import Loader from "@/Components/Loader";
import InfiniteScroll from "react-infinite-scroller";
import {Link, router} from "@inertiajs/react";
import queryString from 'query-string';
import Buy from "@/Components/Buy";

function postUrl(params: any) {
    const stringified = queryString.stringify(params);
    router.get(`/?${stringified}`);
}

const Listing: React.FC = () => {

    const parsed = useRef(queryString.parse(location.search, {parseNumbers: true}));
    const isMounted = useRef(false);
    const [loading, setLoading] = useState(false)
    const [search, setSearch] = useState(() => {
        const query = parsed.current;
        return String(query?.search || '').trim();
    })
    const [filters, setFilters] = useState(() => {
        const query = parsed.current;
        const tags =  String((query?.tags || '')).trim();
        return tags.split(',').filter(item => item !== '');
    })
    const [tags, setTags] = useState([])
    const [sortBy, setSortBy] = useState(() => {
        const query = parsed.current;
        if ((query?.sortBy === 'point') && (query?.sortOrder === 'desc')) {
            return 'highest-price';
        }
        return 'lowest-price'
    })
    const [books, setBooks] = useState<any>({})
    const [booksData, setBooksData] = useState<any>([])
    const [hasMore, setHasMore] = useState(true);
    const [currentPage, setCurrentPage] = useState(1);
    const [params, setParams] = useState({
        page: 1,
        perPage: 9,
        sortBy: 'point',
        sortOrder: 'asc',
        ...parsed.current
    })

    async function fetchBooks(queryParams: any) {

        const queryString = Object.keys(queryParams)
            .map(key => encodeURIComponent(key) + '=' + encodeURIComponent(queryParams[key]))
            .join('&');

        try {
            let config = {
                method: 'get',
                maxBodyLength: Infinity,
                url: `/api/books?${queryString}`,
                headers: {
                    'Accept': 'application/json',
                },
            };
            const data = await axios.request(config)
            setBooks(data.data);
            setBooksData((prevBooks: any) => [...prevBooks, ...data.data.data]);
            setCurrentPage(queryParams.page || 1);
            setHasMore(data.data.current_page < data.data.last_page);
        } catch (error) {
            alert(JSON.stringify(error));
            console.error('Error fetching books:', error);
        }
    }

    useEffect(() => {
        setLoading(true)
        fetchBooks({
            page: 1,
            perPage: 9,
            sortBy: 'point',
            sortOrder: 'asc',
            ...parsed.current
        })
            .then(value => value)
            .finally(() => {
                setLoading(false)
            })
    }, []);

    useEffect(() => {
        if (isMounted.current) {
            postUrl(params);
        } else {
            isMounted.current = true;
        }
    }, [params]);

    function handleSortBy(e: any) {
        const val = e.target.value;
        setSortBy(val);
        if (val === 'highest-price') {
            setParams(prevState => ({
                ...prevState,
                sortBy: 'point',
                sortOrder: 'desc'
            }))
        } else if (val === 'lowest-price') {
            setParams(prevState => ({
                ...prevState,
                sortBy: 'point',
                sortOrder: 'asc'
            }))
        }
    }

    const loadMore = async () => {
        await fetchBooks({
            ...params,
            page: currentPage + 1,
        });
    };

    const [isOpen, setIsOpen] = useState(false);

    const openModal = () => {
        setIsOpen(true);
    };

    const closeModal = () => {
        setIsOpen(false);
    };

    return (
        <div className={'mx-auto max-w-[1920px]'}>
            <div className="flex pb-16 pt-7 lg:pt-7 lg:pb-20">
                {/*<ModalSidebar/>*/}
                <Sidebar {...{filters, setFilters, tags, setTags, search, setSearch, setParams}}/>
                <div className="w-full lg:pt-4 lg:ltr:-ml-4 lg:rtl:-mr-2 xl:ltr:-ml-8 xl:rtl:-mr-8 lg:-mt-1 pl-4">
                    <div className="flex items-center justify-between mb-6">
                        <button
                            onClick={openModal}
                            className="flex items-center px-4 py-2 text-sm font-semibold transition duration-200 ease-in-out border rounded-md lg:hidden text-brand-dark border-border-base focus:outline-none hover:border-brand hover:text-brand">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18px" height="14px" viewBox="0 0 18 14">
                                <g id="Group_36196" data-name="Group 36196" transform="translate(-925 -1122.489)">
                                    <path id="Path_22590" data-name="Path 22590"
                                          d="M942.581,1295.564H925.419c-.231,0-.419-.336-.419-.75s.187-.75.419-.75h17.163c.231,0,.419.336.419.75S942.813,1295.564,942.581,1295.564Z"
                                          transform="translate(0 -169.575)" fill="currentColor"></path>
                                    <path id="Path_22591" data-name="Path 22591"
                                          d="M942.581,1951.5H925.419c-.231,0-.419-.336-.419-.75s.187-.75.419-.75h17.163c.231,0,.419.336.419.75S942.813,1951.5,942.581,1951.5Z"
                                          transform="translate(0 -816.512)" fill="currentColor"></path>
                                    <path id="Path_22593" data-name="Path 22593"
                                          d="M1163.713,1122.489a2.5,2.5,0,1,0,1.768.732A2.483,2.483,0,0,0,1163.713,1122.489Z"
                                          transform="translate(-233.213)" fill="currentColor"></path>
                                    <path id="Path_22594" data-name="Path 22594"
                                          d="M2344.886,1779.157a2.5,2.5,0,1,0,.731,1.768A2.488,2.488,0,0,0,2344.886,1779.157Z"
                                          transform="translate(-1405.617 -646.936)" fill="currentColor"></path>
                                </g>
                            </svg>
                            <span className="ltr:pl-2.5 rtl:pr-2.5 ml-2">Filters</span>
                        </button>
                        <div className="flex items-center justify-end w-full lg:justify-between">
                            <div
                                className="shrink-0 text-brand-dark font-medium text-15px leading-4 md:ltr:mr-6 md:rtl:ml-6 hidden lg:block mt-0.5">{books?.total || 0} Items
                                Found
                            </div>
                            <div className="relative ltr:ml-2 rtl:mr-2 lg:ltr:ml-0 lg:rtl:mr-0 min-w-[160px]">
                                <div className="flex items-center">
                                    <div
                                        className="shrink-0 text-15px ltr:mr-2 rtl:ml-2 text-brand-dark text-opacity-70 mr-2">Sort
                                        by:
                                    </div>
                                    <div className="relative">
                                        <select
                                            value={sortBy}
                                            onChange={handleSortBy}
                                            className="block appearance-none w-full bg-white border border-gray-300 hover:border-gray-400 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline cursor-pointer">
                                            <option value="lowest-price">Lowest Price</option>
                                            <option value="highest-price">Highest Price</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    {/* Modal Sidebar */}
                    <div
                        id="sidebar"
                        className={`fixed inset-y-0 left-0 w-full bg-white z-50 transform ${isOpen ? 'translate-x-0' : '-translate-x-full'
                        } transition-transform duration-300 ease-in-out`}
                    >
                        {/* Sidebar Content */}
                        <div className="flex flex-col h-full">
                            {/* Header */}
                            <div className="p-4 border-b">
                                <h2 className="text-lg font-semibold">Filters</h2>
                                <button onClick={closeModal} className="absolute top-4 right-4 text-gray-600 hover:text-gray-900 focus:outline-none">
                                    <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
                                    </svg>
                                </button>
                            </div>
                            <div className="flex-1 overflow-y-auto p-4">
                                <Sidebar {...{filters, setFilters, tags, setTags, search, setSearch, setParams,
                                    className: 'visible'
                                }}/>
                            </div>
                        </div>
                    </div>
                    {loading && (
                        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
                            <Loader/>
                        </div>
                    ) || (
                        <>
                            {booksData?.length > 0 && (
                                <>
                                    <InfiniteScroll
                                        pageStart={0}
                                        loadMore={loadMore}
                                        hasMore={hasMore}
                                        loader={<div key={'loader'}
                                                     className={'flex justify-center items-center mt-4'}>Loading...</div>}
                                    >
                                        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 xl:grid-cols-3 gap-4">
                                            {booksData.map((book: any, index: number) => (
                                                <div
                                                    key={`book-${book.id}-${index}`}
                                                    className="bg-white rounded-lg shadow-md overflow-hidden">
                                                    <Link href={route('book-show', book.id)}>
                                                        <img
                                                            src={book.cover_image}
                                                            alt={book.title}
                                                            className="w-full h-48 object-cover object-center"/>
                                                    </Link>
                                                    <Link href={route('book-show', book.id)}
                                                          className="p-4 block">
                                                        <h2 className="text-gray-800 font-semibold text-lg">{book.title}</h2>
                                                        <p className="mt-2 text-gray-600">
                                                            <strong>Writer:</strong> {book.writer}
                                                        </p>
                                                        <p className="mt-2 text-gray-600">
                                                            <strong>Tags:</strong> {book.tags}
                                                        </p>
                                                        <div className="flex justify-between items-center mt-4">
                                                                <span
                                                                    className="text-gray-900 font-bold">${book.point}</span>
                                                        </div>
                                                    </Link>
                                                    <div className="flex justify-between items-center p-4">
                                                        <Buy book_id={book.id}/>
                                                    </div>
                                                </div>
                                            ))}
                                        </div>
                                    </InfiniteScroll>
                                </>
                            ) || (
                                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">Not Found!</div>
                            )}
                        </>
                    )}
                </div>
            </div>
        </div>
    );
};

export default Listing;
